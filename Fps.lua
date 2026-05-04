local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local YTLabel = Instance.new("TextLabel")
local FPSLabel = Instance.new("TextLabel")
local UltraLowBtn = Instance.new("TextButton")
local HideBtn = Instance.new("TextButton")
local ToggleButton = Instance.new("TextButton")
local UIBox = Instance.new("UICorner")
local BtnBox1 = Instance.new("UICorner")
local BtnBox2 = Instance.new("UICorner")

ScreenGui.Name = "GxGrafixBooster"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 210)
MainFrame.Active = true
MainFrame.Draggable = true

UIBox.CornerRadius = UDim.new(0, 12)
UIBox.Parent = MainFrame

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "VPS BOOSTER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 12)

YTLabel.Parent = MainFrame
YTLabel.Position = UDim2.new(0, 0, 0.2, 0)
YTLabel.Size = UDim2.new(1, 0, 0, 20)
YTLabel.Text = "Yt : GxGrafix"
YTLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
YTLabel.BackgroundTransparency = 1
YTLabel.TextSize = 15
YTLabel.Font = Enum.Font.SourceSansItalic

FPSLabel.Parent = MainFrame
FPSLabel.Position = UDim2.new(0, 0, 0.35, 0)
FPSLabel.Size = UDim2.new(1, 0, 0, 30)
FPSLabel.Text = "FPS: Calculating..."
FPSLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
FPSLabel.BackgroundTransparency = 1
FPSLabel.TextSize = 20

UltraLowBtn.Parent = MainFrame
UltraLowBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
UltraLowBtn.Size = UDim2.new(0.8, 0, 0, 35)
UltraLowBtn.Text = "Boost Graphics"
UltraLowBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
UltraLowBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UltraLowBtn.Font = Enum.Font.SourceSansBold
BtnBox1.Parent = UltraLowBtn

HideBtn.Parent = MainFrame
HideBtn.Position = UDim2.new(0.1, 0, 0.78, 0)
HideBtn.Size = UDim2.new(0.8, 0, 0, 35)
HideBtn.Text = "Hide UI"
HideBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
HideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HideBtn.Font = Enum.Font.SourceSansBold
BtnBox2.Parent = HideBtn

ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 80, 0, 35)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Text = "Open"
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Visible = false
ToggleButton.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 10)

local function SetUltraLow()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = false
    
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") then
            v.Enabled = false
        end
    end
end

local function SendJoinChat()
    local chatRemote = game:GetService("ReplicatedStorage"):FindFirstChild("SayMessageRequest", true)
    if chatRemote then
        chatRemote:FireServer("Script Loaded - Yt: GxGrafix", "All")
    end
end

UltraLowBtn.MouseButton1Click:Connect(function()
    SetUltraLow()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "GxGrafix";
        Text = "Update Cek Yt";
        Duration = 3;
    })
end)

HideBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    ToggleButton.Visible = true
end)

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    ToggleButton.Visible = false
end)

game:GetService("RunService").RenderStepped:Connect(function(dt)
    FPSLabel.Text = "FPS: " .. math.floor(1/dt)
end)

-- Auto Run
SetUltraLow()
SendJoinChat()

