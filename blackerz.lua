local modules = {}

local http = require("coro-http");
local json = require("json");

--[[
     HTTP request, blackerz.herokuapp.com API
]]

function modules.GetBotInfo(botId)
    local res, body = http.request("GET", "https://blackerz.herokuapp.com/api/v1/bots/"..tostring(botId),
      {{"Content-Type", "application/json"}})
    --print(body)
    return json.parse(body)
end





return modules;
