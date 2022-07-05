--!strict
--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")



--Fusion
local Fusion = require(ReplicatedStorage.Fusion)
local New = Fusion.New
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local OnChange = Fusion.OnChange



--Creating the hoarcekat story
return function(target)
    local gui = New "Frame" {
        BackgroundColor3 = Color3.fromRGB(89, 71, 209),
        Parent = target,
        Position = UDim2.fromScale(.5,.5),
        AnchorPoint = Vector2.new(.5, .5),
        Size = UDim2.new(.5,0,.5,0),
        Name = "MyFirstGfui",

        [Children] = {
            New "TextButton" {
                Position = UDim2.new(0.5, 0, 0.5, -100),
                AnchorPoint = Vector2.new(.5, .5),
                Size = UDim2.fromOffset(200, 50),
    
                Text = "Click me!",
    
                [OnEvent "Activated"] = function(...)
                    print("Clicked!", ...)
                end
            },
    
            New "TextBox" {
                Position = UDim2.new(0.5, 0, 0.5, 100),
                AnchorPoint = Vector2.new(.5, .5),
                Size = UDim2.fromOffset(200, 50),
    
                Text = "",
                ClearTextOnFocus = false,
    
                [OnChange "Text"] = function(newText)
                    print(newText)
                end
            }
        }

    }
    
    print("Lmao")
    return function() gui:Destroy() end
end