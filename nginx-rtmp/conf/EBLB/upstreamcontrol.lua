-- 0.3 changes: prevent IWCP usage when IWCP is not loaded (1 worker)

local args = ngx.req.get_uri_args()
local i_stream, i_peer, i_name, i_server, i_down, i_gui, ok, err, cdone, i_vdown, i_temp, i_addr_ip, addr_port
i_gui = args["gui"]
i_stream = args["stream"] -- upstream name
i_peer = args["peer"]     -- number
i_name = args["name"]     -- resolved
i_server = args["server"] -- from conf
i_addr_ip = args["addr"]  -- from runtime current worker only
i_down = args["down"]
i_vdown = args["vdown"]
local worker_pid = tostring(ngx.worker.pid())
local Query = ngx.shared.iworkcomproto
local iwcp_t = os.time()  -- create unique message keys
local iwcp_r = tostring(math.random(1000,9999)) -- create unique message keys part2
-- 
if i_vdown then i_down = i_vdown end
if i_down == "1" then i_down = "true" end
if i_down == "0" then i_down = "false" end
if i_name then i_temp = ngx.re.gsub(i_name, "%3A", ":") end
if i_name then i_name = i_temp end
if i_server then i_temp = ngx.re.gsub(i_server, "%3A", ":") end
if i_server then i_server = i_temp end
if i_addr_ip then i_temp = ngx.re.gsub(i_addr_ip, "%3A", ":") end
if i_addr_ip then i_addr_ip = i_temp end
cdone = 1
-- 

if i_down and cdone then
  local upstream = require "ngx.upstream"
  if i_down == "true" then
    ok, err = upstream.set_peer_down(i_stream, false, tonumber(i_peer), true)
    if ok and iwcp_expire then
      Query:set("IWCP_MSG_PD_"..iwcp_t..iwcp_r,"#"..worker_pid.."#!"..tostring(i_stream)..","..tonumber(i_peer)..",0",iwcp_expire)
    end
    ngx.print("down ",ok," ",err,"\n")
  else
    ok, err = upstream.set_peer_down(i_stream, false, tonumber(i_peer), false)
    if ok and iwcp_expire then
      Query:set("IWCP_MSG_PU_"..iwcp_t..iwcp_r,"#"..worker_pid.."#!"..tostring(i_stream)..","..tonumber(i_peer)..",1",iwcp_expire)
    end
    ngx.print("up ",ok," ",err,"\n")
  end
  if not i_gui then return end
  cdone = 0
end

if i_addr_ip and cdone then
  local upstream = require "ngx.upstream"
  ok, err = upstream.set_peer_addr(i_stream, false, tonumber(i_peer), i_addr_ip)
  if ok and iwcp_expire then
    Query:set("IWCP_MSG_PI_"..iwcp_t..iwcp_r,"#"..worker_pid.."#!"..tostring(i_stream)..","..tonumber(i_peer)..","..i_addr_ip,iwcp_expire)
  end
  ngx.print("changed ",ok," ",err,"\n")
  if not i_gui then return end
  cdone = 0
end

if cdone == 1 then ngx.print("<b>not yet implemented !</b>\n") end
if not i_gui then return end

ngx.print("<html><head><META HTTP-EQUIV=\"REFRESH\" CONTENT=\"1; URL=/upstreamstatus\"></head></html>\n")
return
