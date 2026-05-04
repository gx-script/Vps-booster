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
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
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
ScrollFrame.CanvasSize = UDim2.new(0, 0, 5, 0)

UIListLayout.Parent = ScrollFrame
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function createButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.95, 0, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = name
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.Parent = ScrollFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
end

createButton("REAL INVISIBLE (FE)", function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character then
        local root = character:FindFirstChild("HumanoidRootPart")
        if root then
            local clone = root:Clone()
            root:Destroy()
            clone.Parent = character
            character:MoveTo(character.PrimaryPart.Position + Vector3.new(0, 5, 0))
        end
    end
end)

createButton("VPS Booster", function()
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then v.Material = Enum.Material.SmoothPlastic v.Reflectance = 0 end
        if v:IsA("Decal") or v:IsA("Texture") then v:Destroy() end
    end
end)

local aimbot = false
createButton("Auto Aim (R6/R15)", function()
    aimbot = not aimbot
    game:GetService("RunService").RenderStepped:Connect(function()
        if aimbot then
            local target = nil
            local dist = math.huge
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character then
                    local head = v.Character:FindFirstChild("Head") or v.Character:FindFirstChild("HumanoidRootPart")
                    if head then
                        local d = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - head.Position).Magnitude
                        if d < dist then dist = d target = head end
                    end
                end
            end
            if target then workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Position) end
        end
    end)
end)

local noclips = false
createButton("Noclip", function()
    noclips = not noclips
    game:GetService("RunService").Stepped:Connect(function()
        if noclips and game.Players.LocalPlayer.Character then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

createButton("Speed Hack (100)", function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100 end)
createButton("Jump Power (150)", function() game.Players.LocalPlayer.Character.Humanoid.JumpPower = 150 end)
createButton("Full ESP", function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character then
            local h = Instance.new("Highlight", v.Character)
            h.FillColor = Color3.fromRGB(255, 0, 0)
        end
    end
end)
createButton("Anti AFK", function()
    game.Players.LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)
createButton("Infinite Jump", function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end)
createButton("Spin Bot", function()
    local val = Instance.new("BodyAngularVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
    val.AngularVelocity = Vector3.new(0, 50, 0)
    val.MaxTorque = Vector3.new(0, math.huge, 0)
end)
createButton("BTools", function()
    for i = 1, 4 do
        local tool = Instance.new("HopperBin", game.Players.LocalPlayer.Backpack)
        tool.BinType = i
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
