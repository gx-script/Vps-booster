local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local YTLabel = Instance.new("TextLabel")
local FPSLabel = Instance.new("TextLabel")
local UIBox = Instance.new("UICorner")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local ToggleButton = Instance.new("TextButton")

ScreenGui.Name = "GxEyeUltimateV3"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Position = UDim2.new(0.3, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true
UIBox.CornerRadius = UDim.new(0, 15)
UIBox.Parent = MainFrame

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "GX EYE ULTIMATE V3"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 15)

YTLabel.Parent = MainFrame
YTLabel.Position = UDim2.new(0, 0, 0.13, 0)
YTLabel.Size = UDim2.new(1, 0, 0, 20)
YTLabel.Text = "Yt : GxGrafix"
YTLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
YTLabel.BackgroundTransparency = 1
YTLabel.TextSize = 14

FPSLabel.Parent = MainFrame
FPSLabel.Position = UDim2.new(0, 0, 0.18, 0)
FPSLabel.Size = UDim2.new(1, 0, 0, 25)
FPSLabel.Text = "FPS: --"
FPSLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
FPSLabel.BackgroundTransparency = 1

ScrollFrame.Parent = MainFrame
ScrollFrame.Position = UDim2.new(0.05, 0, 0.26, 0)
ScrollFrame.Size = UDim2.new(0.9, 0, 0.7, 0)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 2
ScrollFrame.CanvasSize = UDim2.new(0, 0, 4, 0)

UIListLayout.Parent = ScrollFrame
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function createButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.95, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = name
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.Parent = ScrollFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
end

local killAura = false
createButton("Auto Kill Spawn", function()
    killAura = not killAura
    task.spawn(function()
        while killAura do
            task.wait(0.1)
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and v.Character.Humanoid.Health > 0 then
                    workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, v.Character.Head.Position)
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                    task.wait(0.01)
                    game:GetService("VirtualUser"):Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                end
            end
        end
    end)
end)

local noclips = false
createButton("Noclip (Wallbang)", function()
    noclips = not noclips
    game:GetService("RunService").Stepped:Connect(function()
        if noclips and game.Players.LocalPlayer.Character then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

createButton("Real Invisible (FE)", function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart:Destroy()
    end
end)

createButton("God Mode (Infinity HP)", function()
    game.Players.LocalPlayer.Character.Humanoid.MaxHealth = math.huge
    game.Players.LocalPlayer.Character.Humanoid.Health = math.huge
end)

createButton("VPS Booster (No Lag)", function()
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then v.Material = Enum.Material.SmoothPlastic v.Reflectance = 0 end
        if v:IsA("Decal") or v:IsA("Texture") then v:Destroy() end
    end
end)

createButton("Walkspeed (100)", function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100 end)
createButton("JumpPower (150)", function() game.Players.LocalPlayer.Character.Humanoid.JumpPower = 150 end)
createButton("Full ESP", function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character then
            local h = Instance.new("Highlight", v.Character)
            h.FillColor = Color3.fromRGB(255, 0, 0)
        end
    end
end)

createButton("Infinite Yield", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)

createButton("Hide UI", function()
    MainFrame.Visible = false
    ToggleButton.Visible = true
end)

ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 80, 0, 30)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Text = "GX OPEN"
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Visible = false
Instance.new("UICorner", ToggleButton)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    ToggleButton.Visible = false
end)

game:GetService("RunService").RenderStepped:Connect(function(dt)
    FPSLabel.Text = "FPS: " .. math.floor(1/dt)
end)
