local rng = Random.new()

local charset = {}
for i = 48,  57 do table.insert(charset, string.char(i)) end
for i = 65,  90 do table.insert(charset, string.char(i)) end
for i = 97, 122 do table.insert(charset, string.char(i)) end
local function RandomCharacters(length)
  if length > 0 then
    return RandomCharacters(length - 1) .. charset[rng:NextInteger(1, #charset)]
  else
    return ""
  end
end

local Dex = game:GetObjects("rbxassetid://9553291002")[1]
if syn and syn.protect_gui then syn.protect_gui(Dex) end
Dex.Name = RandomCharacters(rng:NextInteger(5, 20))
Dex.Parent = game:GetService("CoreGui")
    
local function Load(Obj, Url)
local function GiveOwnGlobals(Func, Script)
    local Fenv = {}
    local RealFenv = {script = Script}
    local FenvMt = {}
    FenvMt.__index = function(a,b)
        if RealFenv[b] == nil then
            return getfenv()[b]
        else
            return RealFenv[b]
        end
    end
    FenvMt.__newindex = function(a, b, c)
        if RealFenv[b] == nil then
            getfenv()[b] = c
        else
            RealFenv[b] = c
        end
    end
    setmetatable(Fenv, FenvMt)
    setfenv(Func, Fenv)
    return Func
end

local function LoadScripts(Script)
    if Script.ClassName == "Script" or Script.ClassName == "LocalScript" then
        spawn(function()
            GiveOwnGlobals(loadstring(Script.Source, "=" .. Script:GetFullName()), Script)()
        end)
    end
    for i,v in pairs(Script:GetChildren()) do
        LoadScripts(v)
    end
end

LoadScripts(Obj)
end

Load(Dex)

-- https://raw.githubusercontent.com/legitimate-0x1/__0x1/main/Developer-Tools/Dex%20(Synapse%20Edition).lua
