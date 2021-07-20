local discordia = require('discordia')
local JSON = require("json")
local js = require("./js.lua")
local blackerz = require("./blackerz.lua")
local client = discordia.Client()
local owners = {
  ["775363892167573535"]="Ghosteez"
  --[[
      table of owners
      remove mine and add yourself
      all values are comma separated
  ]]
  
}

-- prefix
local prefix = "t"

function eval(s)
    return assert(loadstring(s))()
end

client:on('ready', function()
  -- set your status here
  client:setGame("blackerz.tk (discordia)");
	print('Logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message)
  local msgcontent = js.String.new(message.content);
  if (not msgcontent:StartsWith(prefix) or not owners[message.author.id]) then return end;
  local args = msgcontent:Splice(#prefix):Trim():Split(" +")
  local cmd = args:Shift():ToLowerCase().RawString
  print(msgcontent:StartsWith(prefix), cmd)
  local pengirim = message.author
	if cmd == "ping" then
		message.channel:send('m');
	elseif cmd == "eval" then
   local toEval = args:Join(" ").RawString;
   if not toEval or #toEval < 1 then
     return message.channel:send("no expression expected");
   end
   print(toEval)
   local s, er;
   s, er = pcall(function() 
      local evaled = tostring(eval(toEval) or 'nil') 
      return message.channel:send("```lua\n"..evaled.."\n```")
   end)
   if not s and er then
    print("mengerror")
    return message.channel:send("```lua\n"..tostring(er).."\n```")
   end
  elseif cmd == "botinfo" then
    --[[
        Example bot info using our API
        https://blackerz.herokuapp.com
    ]]
    local botId = args:Dapat(0)
    if tonumber(botId) == nil then return message.channel:send("First parameter must be valid **int32**") end
    local data = blackerz.GetBotInfo(args:Dapat(0)) or {}
    if not data or data.error then return message.channel:send(data.error or "No bot found"); end
    message.channel:send({embed= {
      title="**"..data.tag.."** bot", 
    description=js.String.new("**Bot Info:** "):Tambah(data.tag):Tambah(" | `"):Tambah(botId):Tambah("`\n**Owner:** "):Tambah(data.owner.name):Tambah(" | `"):Tambah(data.owner.id):Tambah("`\n**Upvotes:** "):Tambah(data.upvotes):Tambah("\n**Invite Link:** [click me]("):Tambah(data.inviteLink or ("https://discord.com/oauth2/authorize?client_id="..tostring(botId).."&permissions=335578198&scope=bot")):Tambah(")\n**Prefix:** `"):Tambah(data.prefix or "unknown"):Tambah("`\n\n"):Tambah(data.ShortDescription).RawString,
    color = 0x00FFFF,
    thumbnail = {url="https://cdn.discordapp.com/avatars/"..data.id.."/"..data.avatar},
    footer = {text="Requested by "..pengirim.tag},
     timestamp = js.Date.new():ToString()
    }})
  end
end)

--[[
     Add "BotToken" in environment variables
     containing your bot token
]]
client:run('Bot '..os.getenv("BotToken"))
