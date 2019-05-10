-- Inter Worker Communication Protocol, designed for nginx for Windows but works for any OS
-- 3-3-2015 v0.3 beta http://nginx-win.ecsds.eu/
-- 0.1: initial design
-- 0.2: public release
-- 0.3: added lock, prevent re-entry while processing message

-- set only once, global vars, 8 workers * 5 seconds = +-40 second for all workers to handle a message
if not iwcp_delay then
-- worker wake up every 5 seconds
    iwcp_delay = 5
-- expire messages after 60 seconds
    iwcp_expire = 60
    iwcp_debug = nil -- or 1 to enable
    iwcp_show = 1
    math.randomseed(os.time())
    local unused = math.random(1000,9999)
end
-- local to worker
local handler
local worker_pid = tostring(ngx.worker.pid())
local upstream = require "ngx.upstream"
local log = ngx.log
local ERR = ngx.ERR
local NOTICE = ngx.NOTICE
local INFO = ngx.INFO
local WARN = ngx.WARN
local DEBUG = ngx.DEBUG
local Query = ngx.shared.iworkcomproto
local QResult, wmsg, keylock
local tvar1, keys, key
local from, to, err, i
local iwcp_one, iwcp_two, iwcp_tree

handler = function (premature)
    if iwcp_debug then ngx.log(ngx.ERR, "timer activation for worker: "..worker_pid) end

    keys = Query:get_keys(0)
    for _,key in pairs(keys) do
      -- peer message handling begin
      from, to, err = ngx.re.find(key, "IWCP_MSG_P", "i")
      if from then
        QResult = Query:get(key)
        tvar1 = "#"..worker_pid.."#"
        from, to, err = ngx.re.find(QResult, tvar1, "i") -- is this worker PID in here?
        -- if not true we have a message to deal with, add PID to msg when finished processing
        if not from then -- and not (keylock == key) then
            -- keylock = key -- if processing takes a while make sure we don't process same msg(key) before finishing
            -- do we need to prevent re-entry or do we need to advice to pass long running jobs to a co-socket?
            if iwcp_show then ngx.log(ngx.ERR, "message for worker: "..worker_pid..", key: "..key..", msg: "..QResult) end
            from, to, err = ngx.re.find(QResult, "!", "i")
            i = string.sub(QResult, from+1, string.len(QResult)) -- get message parameters
            iwcp_one, iwcp_two, iwcp_tree = i:match("([^,]+),([^,]+),([^,]+)") -- split up parameters
            -- all commands and values are in vars, run commands in this worker
            from, to, err = ngx.re.find(key, "IWCP_MSG_PD_", "i") -- peer down
            if from then
                ok, err = upstream.set_peer_down(iwcp_one, false, tonumber(iwcp_two), true)
            end
            from, to, err = ngx.re.find(key, "IWCP_MSG_PU_", "i") -- peer up
            if from then
                ok, err = upstream.set_peer_down(iwcp_one, false, tonumber(iwcp_two), false)
            end
            from, to, err = ngx.re.find(key, "IWCP_MSG_PI_", "i") -- peer change addr(ip:port)
            if from then
                ok, err = upstream.set_peer_addr(iwcp_one, false, tonumber(iwcp_two), iwcp_tree)
            end
            -- log results
            if iwcp_show then ngx.log(ngx.ERR, "result: "..tostring(ok)..", for worker: "..worker_pid..", err: "..tostring(err)..", key: "..key) end
            -- update key
            QResult = "#"..worker_pid..QResult
            Query:replace(key,QResult,iwcp_expire)
            -- keylock = nil
        end
      end
      -- peer message handling end
    end

    if premature then
        return
    end
    ok, err = ngx.timer.at(iwcp_delay, handler)
    if not ok then
        if iwcp_debug then ngx.log(ngx.ERR, "failed to create the timer: ", err) end
        return
    end
end

ok, err = ngx.timer.at(iwcp_delay, handler)
if not ok then
    if iwcp_debug then ngx.log(ngx.ERR, "failed to create the timer: ", err) end
    return
end
