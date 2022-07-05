--!strict
--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")



--Fusion
local Fusion = require(ReplicatedStorage.Fusion)
local State = Fusion.State
local New = Fusion.New
local Computed = Fusion.Computed
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent



--Fusion States
local Clicks = State(0) --Used to keep track of how many timees the button has been clicked



--Creating the hoarcekat story
return function(target)
    --Creating the main frame holding all the guis
    local MainFrame = New "Frame" {

        --Setting the size and position
        Parent = target,
        Size = UDim2.fromScale(.8,.8),
        Position = UDim2.fromScale(.5,.5),
        AnchorPoint = Vector2.new(.5, .5),

        --Changing the colour of the bg
        BackgroundColor3 = Color3.fromRGB(22, 45, 137),

        --Creating the rest of the guis
        [Children] = {

            --Creating the clicker button
            New "TextButton" {

                --Position / Size info
                AnchorPoint = Vector2.new(.5,0),
                Size = UDim2.fromScale(.2,.1),
                Position = UDim2.fromScale(.5,.4),

                --Connecting the button
                [OnEvent "Activated"] = function()
                    Clicks:set(Clicks:get()+1)
                end,

                --Setting the text
                TextScaled = true,
                Text = "Click Me!"
            },

            --Creating the count tracker
            New "TextLabel" {

                --Position / Size info
                AnchorPoint = Vector2.new(.5,0),
                Size = UDim2.fromScale(.4,.1),
                Position = UDim2.fromScale(.5,.53),

                
                --Setting the text
                TextScaled = true,
                Text = Computed(function()
                    return ("Clicked: (%q) Times!"):format(Clicks:get())
                end),
        }

    }
}
    print("Started")
    return function() gui:Destroy() end
end