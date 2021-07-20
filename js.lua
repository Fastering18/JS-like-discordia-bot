-- nyuri utility javascript
local modules = {};
modules.Array = {};
modules.String = {};
modules.Date = {};

--[[
    This doesnt wrap all of javascript functions
    Fastering18
]]

local Array = {};
Array.__index = Array;
Array.__tostring = function(self)
   return "["..table.concat(self.RawTable, ", ").."]";
end

local String = {};
String.__index = String;
String.__tostring = function(self)
   return self.RawString;
end
String.__add = function(s1, s2)
  if type(s2) == "string" then
    return modules.String.new(s1.RawString..s2)
  elseif type(s2) == "table" and type(s2.RawString) == "string" then 
    return modules.String.new(s1.RawString..s2.RawString)
  elseif type(s2) == "number" then
    return modules.String.new(s1.RawString..tostring(s2))
  else
    error("cannot add "..type(s1).." with "..type(s2))
    return;
  end
end
String.__eq = function(s1, s2)
  print(type(s2))
  if type(s2) == "string" then
    return s1.RawString == s2
  elseif type(s2) == "table" and type(s2.RawString) == "string" then 
    return s1.RawString == s2.RawString
  else
    return s1.RawString == tostring(s2)
  end
end

local Date = {}
Date.__index = Date
Date.__tostring = function(self) 
  return os.date("%Y-%m-%dT%H:%M:%S.000Z", self.time)
end

modules.Array.new = function(...)
   local isi = {...};
   local self = setmetatable({}, Array);
   if #isi == 0 then
     self:Tambah()
   elseif type(isi[0]) == "table" and #isi == 1 then
     self.RawTable = isi[0];
   else
     self.RawTable = isi;
   end
   return self;
end

function Array:Tambah(dt)
  if (not (type(self.RawTable) == "table")) then self.RawTable = {} end;
  if (not dt) then return end;
  self.RawTable[#self.RawTable + 1] = dt;
  return #self.RawTable - 1;
end

function Array:Dapat(idx)
  if (not (type(self.RawTable) == "table")) then self.RawTable = {} end;
  if (not type(fn) == "number") then return end;
  return self.RawTable[idx + 1];
end

function Array:ForEach(fn)
  if (not (type(self.RawTable) == "table")) then self.RawTable = {} end;
  if (not type(fn) == "function") then return end;
  coroutine.resume(coroutine.create(function()
    for i, v in pairs(self.RawTable) do
      fn(i, v)
    end
  end))
  return;
end

function Array:GetRaw()
  return tostring(self)
end

function Array:Slice(start)
  if (not (type(self.RawTable) == "table")) then self.RawTable = {} end;
  if (not (type(start) == "number")) then return end;
  if (start < 0) then return print("Cannot slice below 0") end;
  for i = 1, start + 1, 1 do
   table.remove(self.RawTable, i);
  end
  return self;
end

function Array:Join(sepr)
  if (not (type(self.RawTable) == "table")) then self.RawTable = {} end;
  return modules.String.new(table.concat(self.RawTable, type(sepr) == "string" and sepr or ""))
end

function Array:Shift()
  local n = table.remove(self.RawTable, 1)
  if type(n) == "string" then
    n = modules.String.new(n)
  elseif type(n) == "table" then
    n = modules.Array.new(n)
  end
  return n;
end


modules.String.new = function(...)
   local isi = {...};
   local self = setmetatable({}, String);
   self:Tambah(table.concat(isi));
   return self;
end

function String:Tambah(patr, formt, ...)
  if (not (type(self.RawString) == "string")) then self.RawString = "" end;
  patr = tostring(patr)
  if (not (type(patr) == "string")) then return self end;
  if type(formt) == "string" then
    self.RawString = self.RawString..string.format(patr, formt);
  elseif patr and #patr > 0 then
    self.RawString = self.RawString..patr;
  end
  return self;
end

function String:Splice(strt)
  self.RawString = string.sub(self.RawString, strt + 1);
  return self;
end

function String:Split(patr)
  if (not (type(self.RawString) == "string")) then self.RawString = "" end; 
  local res = modules.Array.new();
  for p in (self.RawString..patr):gmatch("(.-)"..patr) do
    res:Tambah(p);
  end
  return res;
end

function String:Trim()
  self.RawString = string.gsub(self.RawString, "^%s*(.-)%s*$", "%1");
  return self;
end

function String:ToLowerCase()
  self.RawString = string.lower(self.RawString);
  return self;
end

function String:ToUpperCase()
  self.RawString = string.upper(self.RawString);
  return self;
end

function String:StartsWith(nstr)
  if (not (type(nstr) == "string")) then return false end;
  return string.match(self.RawString, "^"..nstr) ~= nil;
end

modules.Date.new = function(currentTime)
  local self = setmetatable({}, Date)
  self.time = type(currentTime) == "number" and currentTime or nil;
  return self;
end

function Date:ToString()
  return tostring(self)
end

function modules.eval(s)
    return assert(loadstring(s))()
end
return modules;
