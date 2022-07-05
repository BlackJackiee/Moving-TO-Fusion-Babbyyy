--!strict
print("----------------Started")
--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")



--Fusion
local Fusion = require(ReplicatedStorage.Fusion)
local State = Fusion.State
local Computed = Fusion.Computed



--Fusion States
local numPlayers = State(5)
local ComputedMsg = Computed(function()
    return ("System: (%q) Are Currently In-Game!"):format(tostring(numPlayers:get()))
end)

print(ComputedMsg:get())
numPlayers:set(12)
print(ComputedMsg:get())


--Creating the hoarcekat story
return function(target)
    
    
    return function() end
end