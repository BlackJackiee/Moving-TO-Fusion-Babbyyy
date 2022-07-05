    --!strict
--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")



--Fusion
local Fusion = require(ReplicatedStorage.Fusion)
local New = Fusion.New
local State = Fusion.State
local OnEvent = Fusion.OnEvent
local Children = Fusion.Children
local Computed = Fusion.Computed


--Creating the hover list item
return function(props)
    --Creating a is hovering var to keep track
    local IsHovering = State(false)

    return New "Frame" {

        --Temp size / position settings
        Size = UDim2.fromScale(.8,.2),
        Position = UDim2.fromScale(.5,.5),
        AnchorPoint = Vector2.new(.5, .5),

        --Main text label settings
        LayoutOrder = tonumber(props.Text:match("%d+")) or 0,

        --Setting the colour and text
        [Children] = {

            --Creating the front TextLabel
            New "TextLabel" {

                --Sizing the text corrently
                Size = UDim2.fromScale(.9,1),

                --Setting the textlabel Style
                BackgroundTransparency = 1,
                TextScaled = true,
                TextColor3 = Color3.fromRGB(255,255,255),
                TextXAlignment = Enum.TextXAlignment.Left,

                --Setting the text
                Text = Computed(function()
                    return ("   • %s"):format(IsHovering:get() and props.HoverText or props.Text)
                end),

                --Setting the hovering var
                [OnEvent "MouseEnter"] = function()
                    IsHovering:set(true)
                end,
                [OnEvent "MouseLeave"] = function()
                    IsHovering:set(false)
                end
                
            },

            --Creating the ui gradient
            Gradient = New "UIGradient" {

                --Setting the colour of the UiGradient
                Color = ColorSequence.new{

                    ColorSequenceKeypoint.new(0,props.Colour1),
                    ColorSequenceKeypoint.new(1,props.Colour2)

                },

                Rotation = -25

            },

            --Rounding the coreners
            New "UICorner" {

                CornerRadius = UDim.new(.2,0)

            }

        }

    }
end



--Creating the hoarcekat story
-- return function(target)
--     local ListItem = HoverListItem {

--         Parent = target,
--         Colour1 = Color3.fromRGB(59, 213, 237),
--         Colour2 = Color3.fromRGB(27, 88, 209),

--         --Setting the text
--         Text = "Big Guy",
--         HoverText = "@ObamaGaming",

--     }
    
--     print("Started")
--     return function() ListItem:Destroy() end
-- end