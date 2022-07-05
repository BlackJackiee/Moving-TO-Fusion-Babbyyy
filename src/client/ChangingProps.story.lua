--!strict
--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")



--Fusion
local Fusion = require(ReplicatedStorage.Fusion)
local New = Fusion.New
local Children = Fusion.Children
local State = Fusion.State
local Computed = Fusion.Computed



--Fusion States
local numPlayers = State(5)
local message = Computed(function()
    return "There are " .. numPlayers:get() .. " online."
end)



--Creating the hoarcekat story
return function(target)
    local MaingGui =  New "TextLabel" {
        Parent = target,
        Position = UDim2.fromScale(.5, .5),
        AnchorPoint = Vector2.new(.5, .5),
        Size = UDim2.fromOffset(200, 50),

        --[[To keep things neat and tidy, you can create
         the computed object directly next to the
        property ]]
        Text = Computed(function()
            return ("There are %s online."):format(numPlayers:get())
        end)

    }
    

    print("Started")
    return function() MaingGui:Destroy() end
end