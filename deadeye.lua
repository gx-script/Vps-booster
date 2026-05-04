local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local YTLabel = Instance.new("TextLabel")
local FPSLabel = Instance.new("TextLabel")
local UIBox = Instance.new("UICorner")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local ToggleButton = Instance.new("TextButton")

ScreenGui.Name = "GxEyeWeaponMaster"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 280)
MainFrame.Active = true
MainFrame.Draggable = true
UIBox.CornerRadius = UDim.new(0, 15)
UIBox.Parent = MainFrame

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "GX EYE WEAPON"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 15)

YTLabel.Parent = MainFrame
YTLabel.Position = UDim2.new(0, 0, 0.15, 0)
YTLabel.Size = UDim2.new(1, 0, 0, 20)
YTLabel.Text = "Yt : GxGrafix"
YTLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
YTLabel.BackgroundTransparency = 1
YTLabel.TextSize = 14

FPSLabel.Parent = MainFrame
FPSLabel.Position = UDim2.new(0, 0, 0.22, 0)
FPSLabel.Size = UDim2.new(1, 0, 0, 20)
FPSLabel.Text = "FPS: --"
FPSLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
FPSLabel.BackgroundTransparency = 1

ScrollFrame.Parent = MainFrame
ScrollFrame.Position = UDim2.new(0.05, 0, 0.32, 0)
ScrollFrame.Size = UDim2.new(0.9, 0, 0.62, 0)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 2
ScrollFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0)

UIListLayout.Parent = ScrollFrame
UIListLayout.Padding = UDim.new(0, 8)
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
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(callback)
end

local aimbotEnabled = false
createButton("Auto Headshot", function()
    aimbotEnabled = not aimbotEnabled
    local lp = game.Players.LocalPlayer
    game:GetService("RunService").RenderStepped:Connect(function()
        if aimbotEnabled then
            local target = nil
            local dist = math.huge
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= lp and v.Character and v.Character:FindFirstChild("Head") then
                    local d = (lp.Character.HumanoidRootPart.Position - v.Character.Head.Position).Magnitude
                    if d < dist then
                        dist = d
                        target = v.Character.Head
                    end
                end
            end
            if target then
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Position)
            end
        end
    end)
end)

local function modifyWeapon(name, damage, fireRate)
    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            local stats = v:FindFirstChild("Stats") or v:FindFirstChild("Config")
            if stats then
                if stats:FindFirstChild("Damage") then stats.Damage.Value = damage end
                if stats:FindFirstChild("FireRate") then stats.FireRate.Value = fireRate end
            end
        end
    end
end

createButton("Add AK47 Mod", function()
    modifyWeapon("AK47", 100, 0.01)
end)

createButton("Add Sniper Mod", function()
    modifyWeapon("Sniper", 999, 0.5)
end)

createButton("Add Shotgun Mod", function()
    modifyWeapon("Shotgun", 50, 0.05)
end)

createButton("One Tap All Weapons", function()
    while wait(1) do
        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
            if v.Name == "Damage" or v.Name == "Dmg" then
                v.Value = 1000
            end
        end
    end
end)

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
