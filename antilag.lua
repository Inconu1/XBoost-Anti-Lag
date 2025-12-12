-- Ultra Boost Anti-Lag GUI (Safe Client-Side)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltraAntiLagGUI"
ScreenGui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 120)
Frame.Position = UDim2.new(0.05, 0, 0.05, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local ButtonRun = Instance.new("TextButton")
ButtonRun.Size = UDim2.new(0, 200, 0, 40)
ButtonRun.Position = UDim2.new(0, 10, 0, 20)
ButtonRun.Text = "تشغيل إزالة اللاغ"
ButtonRun.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ButtonRun.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonRun.Parent = Frame

local ButtonHide = Instance.new("TextButton")
ButtonHide.Size = UDim2.new(0, 200, 0, 40)
ButtonHide.Position = UDim2.new(0, 10, 0, 70)
ButtonHide.Text = "إخفاء الواجهة"
ButtonHide.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ButtonHide.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonHide.Parent = Frame

local function cleanObject(obj)
	if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
		obj.Enabled = false
	end

	if obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
		obj.Enabled = false
	end

	if obj:IsA("MeshPart") then
		obj.RenderFidelity = Enum.RenderFidelity.Performance
	end

	if obj:IsA("BasePart") then
		obj.CastShadow = false
	end
end

local function antiLag()
	for _, obj in pairs(workspace:GetDescendants()) do
		cleanObject(obj)
	end

	local lighting = game:GetService("Lighting")
	lighting.GlobalShadows = false
	lighting.FogEnd = 9e9
	settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end

antiLag()

workspace.DescendantAdded:Connect(function(obj)
	cleanObject(obj)
end)

ButtonRun.MouseButton1Click:Connect(antiLag)

ButtonHide.MouseButton1Click:Connect(function()
	ScreenGui.Enabled = false
end)
