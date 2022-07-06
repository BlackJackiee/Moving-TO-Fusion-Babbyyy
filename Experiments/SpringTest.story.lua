    --!strict
--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")



--Fusion
local Fusion = require(ReplicatedStorage.Fusion)
local New = Fusion.New
local Children = Fusion.Children
local State = Fusion.State
local Spring = Fusion.Spring
local Computed = Fusion.Computed
local OnEvent = Fusion.OnEvent

--Gui Vars
local MinSize,MaxSize = 1,1.4
local MinRotation,MaxRotation = -25,-180
local Colour1Min,Colour1Max = Color3.fromRGB(50, 72, 219),Color3.fromRGB(248, 15, 240)



--Creating the hoarcekat story
return function(target)
    --Creating the size spring
    local SizeTarget = State(MinSize)
    local SpringSize = Spring(SizeTarget,15,.3)

    --Creating the rotation spring
    local RotationTarget = State(MinRotation)
    local SpringRotation = Spring(RotationTarget,25,.5)

    --Creating the colour spring
    local Colour1Target = State(Colour1Min)
    local SpringColour1 = Spring(Colour1Target,5,0.1)
    local Colour2Target = State(Colour1Max)
    local SpringColour2 = Spring(Colour2Target,5,0.1)

    local SpringyGuy = New "Frame" {

        --Setting the parent of the frame
        Parent = target,

        --Sizing / positioing the Guy
        Position = UDim2.fromScale(.5,.5),
        AnchorPoint = Vector2.new(.5,.5),
        Size = Computed(function()
            return UDim2.fromScale(.42*SpringSize:get(),.5*SpringSize:get())
        end),

        --Connecting the hover fx
        [OnEvent "MouseEnter"] = function()
            SizeTarget:set(MaxSize)
            RotationTarget:set(MaxRotation)
            Colour1Target:set(Colour1Max)
            Colour2Target:set(Colour1Min)
        end,
        [OnEvent "MouseLeave"] = function()
            SizeTarget:set(MinSize)
            RotationTarget:set(MinRotation)
            Colour1Target:set(Colour1Min)
            Colour2Target:set(Colour1Max)
        end,

        --Styling the Frame
        [Children] = {

            --Adding a graident
            Gradient = New "UIGradient" {

                --Setting the colour of the UiGradient
                Color = Computed(function()
                    return ColorSequence.new{

                        ColorSequenceKeypoint.new(0,SpringColour1:get()),
                        ColorSequenceKeypoint.new(1,SpringColour2:get())
    
                    }
                end),

                Rotation = Computed(function()
                    return SpringRotation:get()
                end)

            },

            --Rounding the Frame
            Rounding = New "UICorner" {

                CornerRadius = UDim.new(1,0)

            }

        }

    }
    
    print("Started")
    return function() SpringyGuy:Destroy() end
end