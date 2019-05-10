-- 0.3 changes: different layout better overview

local concat = table.concat
local upstream = require "ngx.upstream"
local get_servers = upstream.get_servers
local get_upstreams = upstream.get_upstreams
local us = get_upstreams()
local worker_pid = tostring(ngx.worker.pid())
ngx.print("<html><head><title>Upstream management page</title></head>\n")
ngx.print("<style type=\"text/css\">\n")
ngx.print(".smalltable, .smalltable TH\n")
ngx.print("{\n")
ngx.print("font-family:arial;\n")
ngx.print("font-size:8pt;\n")
ngx.print("}\n")
ngx.print(".smalltable TD\n")
ngx.print("{\n")
ngx.print("font-family:arial;\n")
ngx.print("font-size:8pt;\n")
ngx.print("width:25px;\n")
ngx.print("}\n")
ngx.print("</style>\n")
ngx.print("<body>\n")
for _, u in ipairs(us) do
    ngx.say("<b>Peer status in upstream ", u, ", worker-PID: ",worker_pid,":</b><br>\n<table border=\"1\" width=\"100%\" CLASS=\"smalltable\">")
    local srvs, err = upstream.get_primary_peers(u)
--    local srvs, err = get_servers(u)
    local p_up = " style=\"background:green; color:white;\""
    local p_down = " style=\"background:red; color:white;\""
    local p_addr = " style=\"background:blue; color:white;\""
    local p_name = " style=\"background:lightblue; color:white;\""
    if not srvs then
        ngx.say("failed to get servers in upstream ", u)
    else
      for _, srv in ipairs(srvs) do
        local r_id = _ - 1
        local l_state = 0
        local l_first = 0
        if r_id > 0 then l_first = 1 end
        for k, v in pairs(srv) do
          if k ==       "addr"          then l_state = 1  -- which fields do we want to see?
            elseif k == "server"        then l_state = 1
            elseif k == "fails"         then l_state = 2
            elseif k == "down"          then l_state = 3
            elseif k == "fail_timeout"  then l_state = 2
            elseif k == "weight"        then l_state = 2
            -- values: current_weight, weight, id, fail_timeout, fails, down, effective_weight, name, server, max_fails, addr
          end
          if l_state > 0 then
            if l_first == 1 then ngx.print("<tr></tr>"); l_first = 0 end
            ngx.print("<td style=\"vertical-align:middle\"")
--            if l_state == 2 then ngx.print(" CLASS=\"smalltable TD\"") end
            ngx.print("><form action=\"/upstreamcontrol\" method=\"GET\">")
            p_state = ""
            if k == "server" then p_state = p_name end  -- set a color for specific fields
            if k == "addr" then p_state = p_addr end
            if k == "down" then p_state = p_down end
            if k == "down" and tostring(v) == "false" then p_state = p_up end
            if k == "down" then
              if tostring(v) == "true" then
                vv = false
              else
                vv = true
              end
            end
            local p_test = k.."</td><td style=\"vertical-align:middle\""
--            if l_state == 2 then p_test = p_test.." CLASS=\"smalltable TD\"" end
            p_test = p_test.."><input type=\"text\" value=\""..tostring(v).."\" name=\""..k.."\""..p_state
            if l_state == 2 then p_test = p_test.." maxlength=\"6\" size=\"7\"" end
            if l_state == 3 then p_test = p_test.." maxlength=\"5\" size=\"5\"" end
            p_test = p_test..">"
            ngx.print(p_test)
            ngx.print("<input type=\"hidden\" name=\"gui\" value=\"1\">")
            ngx.print("<input type=\"hidden\" name=\"peer\" value=\"",r_id,"\">")
            ngx.print("<input type=\"hidden\" name=\"stream\" value=\"",u,"\">")
            if k == "down" then
              if tostring(v) == "true" then
                ngx.print("<input type=\"hidden\" name=\"vdown\" value=\"",tostring(vv),"\">")
                ngx.print("<input type=\"submit\" value=\"Up\"></form></td>\n")
              else
                ngx.print("<input type=\"hidden\" name=\"vdown\" value=\"",tostring(vv),"\">")
                ngx.print("<input type=\"submit\" value=\"Down\"></form></td>\n")
              end
            else
              ngx.print("<input type=\"submit\" value=\"Change\"></form></td>\n")
            end
          end
          l_state = 0
        end
      end
    end
  ngx.print("</table><br>")
end
ngx.print("</body></html>\n")
