local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local YTLabel = Instance.new("TextLabel")
local FPSLabel = Instance.new("TextLabel")
local UIBox = Instance.new("UICorner")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local ToggleButton = Instance.new("TextButton")

ScreenGui.Name = "GxEyeUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true
UIBox.CornerRadius = UDim.new(0, 12)
UIBox.Parent = MainFrame

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "GX EYE v1"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 22
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 12)

YTLabel.Parent = MainFrame
YTLabel.Position = UDim2.new(0, 0, 0.13, 0)
YTLabel.Size = UDim2.new(1, 0, 0, 20)
YTLabel.Text = "Yt : GxGrafix"
YTLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
YTLabel.BackgroundTransparency = 1
YTLabel.TextSize = 14

FPSLabel.Parent = MainFrame
FPSLabel.Position = UDim2.new(0, 0, 0.19, 0)
FPSLabel.Size = UDim2.new(1, 0, 0, 25)
FPSLabel.Text = "FPS: --"
FPSLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
FPSLabel.BackgroundTransparency = 1

ScrollFrame.Parent = MainFrame
ScrollFrame.Position = UDim2.new(0.05, 0, 0.28, 0)
ScrollFrame.Size = UDim2.new(0.9, 0, 0.68, 0)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 2

UIListLayout.Parent = ScrollFrame
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function createButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.95, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = name
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.Parent = ScrollFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
end

createButton("VPS Booster", function()
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then v.Material = Enum.Material.SmoothPlastic v.Reflectance = 0 end
        if v:IsA("Decal") or v:IsA("Texture") then v:Destroy() end
        if v:IsA("ParticleEmitter") then v.Enabled = false end
    end
end)

local noclip = false
createButton("Noclip", function()
    noclip = not noclip
    game:GetService("RunService").Stepped:Connect(function()
        if noclip and game.Players.LocalPlayer.Character then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

createButton("Auto Headshot", function()
    local lp = game.Players.LocalPlayer
    game:GetService("RunService").RenderStepped:Connect(function()
        local nearest = nil
        local dist = math.huge
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("Head") then
                local d = (lp.Character.Head.Position - v.Character.Head.Position).Magnitude
                if d < dist then
                    dist = d
                    nearest = v
                end
            end
        end
        if nearest then
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, nearest.Character.Head.Position)
        end
    end)
end)

createButton("Speed Hack", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
end)

createButton("High Jump", function()
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 150
end)

createButton("Full ESP", function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character then
            local h = Instance.new("Highlight", v.Character)
            h.FillColor = Color3.fromRGB(255, 0, 0)
        end
    end
end)

createButton("Infinite Yield", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

createButton("Hide UI", function()
    MainFrame.Visible = false
    ToggleButton.Visible = true
end)

ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 80, 0, 30)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Text = "GX EYE"
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
