local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "xiao xin",
    Icon = "crown",
    Author = "xiao xin",
    AuthorImage = 90840643379863,
    Folder = "CloudHub",
    Size = UDim2.fromOffset(560, 360),
    Transparent = true,
    User = {
        Enabled = true,
        Callback = function() 
            print("clicked") 
        end,
        Anonymous = false
    },
})

Window:EditOpenButton({
    Title = "xiao xin",
    Icon = "crown",
    CornerRadius = UDim.new(1, 0),
    StrokeThickness = 3,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(144, 238, 144)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 0))
    }),
    Draggable = true
})


function Tab(a)
    return Window:Tab({Title = a, Icon = "eye"})
end

function Button(a, b, c)
    return a:Button({Title = b, Callback = c})
end

function Toggle(a, b, c, d)
    return a:Toggle({Title = b, Value = c, Callback = d})
end

function Slider(a, b, c, d, e, f)
    return a:Slider({Title = b, Step = 1, Value = {Min = c, Max = d, Default = e}, Callback = f})
end

function Dropdown(a, b, c, d, e)
    return a:Dropdown({Title = b, Values = c, Value = d, Callback = e})
end

function Input(a, b, c, d, e, f)
    return a:Input({
        Title = b,
        Desc = c or "",
        Value = d or "",
        Placeholder = e or "",
        Callback = f
    })
end


local GeneralTab = Tab("本地通用")


local loops = {}


GeneralTab:Slider({
    Title = "步行速度!",
    Step = 1,
    Value = {Min = 16, Max = 400, Default = 16},
    Callback = function(Speed)
        
        if loops.WalkSpeed then
            loops.WalkSpeed = false
        end
        
        
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Speed
        end
    end
})


GeneralTab:Slider({
    Title = "跳跃高度!",
    Step = 1,
    Value = {Min = 50, Max = 400, Default = 50},
    Callback = function(Jump)
        if loops.JumpPower then
            loops.JumpPower = false
        end
        
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = Jump
        end
    end
})


local gravityValue = 196.2
GeneralTab:Input({
    Title = "重力设置!",
    Desc = "输入重力值",
    Value = "",
    Placeholder = "输入",
    Callback = function(Gravity)
        local num = tonumber(Gravity)
        if num then
            gravityValue = num
            game.Workspace.Gravity = num
        end
    end
})


local nightVisionEnabled = false
GeneralTab:Toggle({
    Title = "夜视",
    Value = false,
    Callback = function(Enabled)
        nightVisionEnabled = Enabled
        
        if Enabled then
            game.Lighting.Ambient = Color3.new(1, 1, 1)
        else
            game.Lighting.Ambient = Color3.new(0, 0, 0)
        end
    end
})


GeneralTab:Toggle({
    Title = "自动应用属性",
    Value = false,
    Callback = function(Enabled)
        if Enabled then
            loops.AutoApply = true
            spawn(function()
                while loops.AutoApply do
                    task.wait(0.5)
                    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                        
                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
                        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
                    end
                end
            end)
        else
            loops.AutoApply = false
        end
    end
})



local GeneralTab = Tab("战斗")



local loops = {}



local players = game:GetService("Players"):GetPlayers()
local localPlayer = game:GetService("Players").LocalPlayer
local main = window:Tab("战斗")
local kill = main:section("战斗", true)
kill:Slider("物品栏数量", "taunt_interval", 6, 1, 9, false, function(value)
 local sum = require(game.ReplicatedStorage.devv.client.Objects.v3item.modules.inventory)sum.numSlots = value
end)

kill:Dropdown("攻击方式", "Player", {"超级拳", "普通拳"}, function(value)
    if value == "超级拳" then
        hitMOD = "meleemegapunch"
    elseif value == "普通拳" then
        hitMOD = "meleepunch"
    end
end)
kill:Toggle("杀戮光环", "Hit", false, function(state)
autokill = state
end)
kill:Toggle("踩踏光环", "Kill", false, function(state)
autostomp = state
end)
kill:Toggle("抓取光环", "grab", false, function(state)
grabplay = state
end)

SnowRUN.Heartbeat:Connect(function()
pcall(function()
