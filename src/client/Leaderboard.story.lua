    --!strict
--Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")



--Fusion
local Fusion = require(ReplicatedStorage.Fusion)
local New = Fusion.New
local Children = Fusion.Children
local State = Fusion.State
local Computed = Fusion.Computed

--Components
local HoverListItem = require(script.Parent.HoverListItem)

--Gui Vars
local PlrInfo = State({

    Callme_jj = {
        DisplayName = "Jeezus_Christ",
        Colour1 = Color3.fromRGB(13, 94, 245),
        Colour2 = Color3.fromRGB(217, 41, 208)
    },

})



--List Item functions
--Function to return an array of all the players in plrinfo
local function GetPlayerList()
    local PlrListArray = {}

    --Creating list items for all the players in the plrinfo dict
    for PlrName,PlrData in pairs(PlrInfo:get()) do
        table.insert(PlrListArray,HoverListItem {

            --Setting the style of the list item
            Colour1 = PlrData.Colour1,
            Colour2 = PlrData.Colour2,

            --Setting the text
            Text = PlrName,
            HoverText = ("@%s"):format(PlrData.DisplayName),

        })
    end

    return PlrListArray
end



--Creating the leaderboard
local Leaderboard = function(props)
    return New "Frame" {
        --Setting the parent of the leaderboard
        Parent = props.Parent,

        --Setting the size / position of the leaderbord
        Size = UDim2.fromScale(.6,.9),
        Position = UDim2.fromScale(.5,.5),
        AnchorPoint = Vector2.new(.5, .5),
        
        --Populating the leaderboard
        [Children] = {

            --Creating the leaderboard header
            Header = New "TextLabel" {

                --Sizing / positioning the header
                Size = UDim2.fromScale(1,.13),

                --Setting the textLabel settings
                TextScaled = true,
                TextColor3 = Color3.fromRGB(255,255,255),
                TextXAlignment = Enum.TextXAlignment.Left,
                Text = "   • Leaderboard",

                --Styling the Header
                BackgroundColor3 = props.AccentColour

            },

            --Creating the ui gradient
            Gradient = New "UIGradient" {

                --Setting the colour of the UiGradient
                Color = ColorSequence.new{

                    ColorSequenceKeypoint.new(0,props.PrimaryColour),
                    ColorSequenceKeypoint.new(1,props.AccentColour)

                },

                Rotation = 90

            },

            --Creating the player name scrolling Frame
            NameFrame = New "ScrollingFrame" {

                --Setting the size / position of the leaderbord
                Size = UDim2.fromScale(1,.87),
                Position = UDim2.fromScale(.5,1),
                AnchorPoint = Vector2.new(.5, 1),
                AutomaticCanvasSize  = Enum.AutomaticSize.Y,

                --Styling the scrolling frame
                BackgroundTransparency = 1,
            
                --populating the list
                [Children] = {

                    --Adding a ui layout
                    UIGridLayout = New "UIGridLayout" {

                        --Styling the ListItems
                        CellSize  = UDim2.fromScale(1,.05),
                        SortOrder = Enum.SortOrder.LayoutOrder

                    },

                    --Adding all the player list items
                    PlayerList = Computed(function()
                        return GetPlayerList()
                    end)
            
                }

            }
        }

    }
end

--Function to add / replace player info
local function SetPlayerInfo(PlrName: string, PlayerData)
    local CurrentPlrInfo = table.clone(PlrInfo:get())
    CurrentPlrInfo[PlrName] = PlayerData
    PlrInfo:set(CurrentPlrInfo)
end

-- Creating the hoarcekat story
return function(target)
    --Making a new Leaderboard
    local LeaderboadGui = Leaderboard {

        --Setting the leaderboard parent
        Parent = target,

        --Setting the style of the leaderboard
        PrimaryColour = Color3.fromRGB(122, 11, 250),
        AccentColour = Color3.fromRGB(16, 174, 213)

    }

    --Adding 50 more names to the gui
    task.spawn(function()
        for i = 1, 50 do
            SetPlayerInfo("RandomBozo"..i,{
                DisplayName = "Jeezus_Christ",
                Colour1 = Color3.fromRGB(math.random(1,100),math.random(1,100),math.random(1,100)),
                Colour2 = Color3.fromRGB(math.random(1,255),math.random(1,255),math.random(1,255))
            })
            task.wait(.05)
         end
    end)
    
    return function()
         LeaderboadGui:Destroy()
     end
end