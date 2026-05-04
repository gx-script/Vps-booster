if not game:IsLoaded() then
    game.Loaded:Wait()
end

local function OptimalkanGrafik()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    
    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = false
    lighting.FogEnd = 9e9
    lighting.Brightness = 1
    
    for _, v in pairs(lighting:GetChildren()) do
        if v:IsA("PostProcessEffect") or v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("SunRaysEffect") then
            v.Enabled = false
        end
    end

    task.spawn(function()
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v:Destroy()
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false
            end
        end
    end)
    
    local terrain = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
    if terrain then
        terrain.WaterWaveSize = 0
        terrain.WaterWaveSpeed = 0
        terrain.WaterReflectance = 0
        terrain.WaterTransparency = 0
    end
end

local function BypassChat(msg)
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("SayMessageRequest", true)
    if remote then
        remote:FireServer(msg, "All")
    end
end

OptimalkanGrafik()
BypassChat("Script Loaded")

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "FPS Booster";
    Text = "Graphics Optimized";
    Duration = 5;
})
