-- MM2 Cosmic GUI Engine
-- Theme: Pitch Black Void, Violet Cosmic Energy, Anime Silhouette

local Player = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Prevent duplicate GUI instances
if CoreGui:FindFirstChild("MM2CosmicUI") then
    CoreGui.MM2CosmicUI:Destroy()
end

-- 1. MAIN SCREEN CANVAS
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2CosmicUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

-- 2. MAIN INTERFACE FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 360)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Pitch black theme
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Allows player to reposition interface
MainFrame.Parent = ScreenGui

-- Neon Purple Border Glow
local BorderStroke = Instance.new("UIStroke")
BorderStroke.Thickness = 2
BorderStroke.Color = Color3.fromRGB(150, 40, 255)
BorderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
BorderStroke.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- 3. BACKGROUND CANVAS (Atmospheric Nebula Layer)
local Background = Instance.new("Frame")
Background.Name = "Background"
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(5, 2, 12)
Background.BorderSizePixel = 0
Background.ClipsDescendants = true
Background.Parent = MainFrame
Instance.new("UICorner", Background).CornerRadius = UDim.new(0, 8)

-- Starfield Generator (Generates drifting stardust inside the GUI)
for i = 1, 45 do
    local Star = Instance.new("Frame")
    Star.Size = UDim2.new(0, math.random(1, 3), 0, math.random(1, 3))
    Star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    Star.BackgroundColor3 = Color3.fromRGB(230, 210, 255)
    Star.BorderSizePixel = 0
    Star.BackgroundTransparency = math.random(2, 6) / 10
    Star.Parent = Background
    
    -- Twinkle & Drift effect
    RunService.RenderStepped:Connect(function()
        local t = tick() + i
        Star.BackgroundTransparency = 0.4 + 0.3 * math.sin(t * 2)
    end)
end

-- 4. ANIME GIRL CANVAS GRAPHIC (Vector Representation)
local CharacterContainer = Instance.new("Frame")
CharacterContainer.Size = UDim2.new(0, 120, 0, 240)
CharacterContainer.Position = UDim2.new(1, -140, 0.5, -100)
CharacterContainer.BackgroundTransparency = 1
CharacterContainer.Parent = Background

-- Hair Background Flow Layer
local HairGlow = Instance.new("Frame")
HairGlow.Size = UDim2.new(0, 90, 0, 140)
HairGlow.Position = UDim2.new(0.5, -45, 0, 10)
HairGlow.BackgroundColor3 = Color3.fromRGB(180, 80, 255) -- Violet Rim highlight
HairGlow.BorderSizePixel = 0
HairGlow.Parent = CharacterContainer
Instance.new("UICorner", HairGlow).CornerRadius = UDim.new(0, 45)

-- Main Silhouette Base
local BodySil = Instance.new("Frame")
BodySil.Size = UDim2.new(0, 60, 0, 180)
BodySil.Position = UDim2.new(0.5, -30, 0, 30)
BodySil.BackgroundColor3 = Color3.fromRGB(12, 5, 20) -- Pitch black silhouette shadow
BodySil.BorderSizePixel = 0
BodySil.Parent = CharacterContainer

-- Subtle hair swaying simulator
RunService.RenderStepped:Connect(function()
    local sway = math.sin(tick() * 1.5) * 4
    HairGlow.Position = UDim2.new(0.5, -45 + sway, 0, 10)
end)

-- 5. HEADER BAR & NAVIGATION
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "COSMIC MM2 ENGINE"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = Color3.fromRGB(220, 180, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = Header

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0.5, -15)
CloseBtn.Text = "×"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 20
CloseBtn.TextColor3 = Color3.fromRGB(150, 40, 255)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Parent = Header
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- 6. MM2 SCRIPT FUNCTION MODULES
local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(0, 360, 0, 290)
Container.Position = UDim2.new(0, 15, 0, 45)
Container.BackgroundTransparency = 1
Container.BorderSizePixel = 0
Container.ScrollBarThickness = 2
Container.ScrollBarImageColor3 = Color3.fromRGB(150, 40, 255)
Container.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 10)
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Parent = Container

-- Helper function to generate clean custom script toggles
local function CreateFeatureButton(text, layoutOrder, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 0, 40)
    Button.BackgroundColor3 = Color3.fromRGB(16, 8, 28)
    Button.Text = "  " .. text
    Button.Font = Enum.Font.GothamSemibold
    Button.TextSize = 12
    Button.TextColor3 = Color3.fromRGB(240, 230, 255)
    Button.TextXAlignment = Enum.TextXAlignment.Left
    Button.LayoutOrder = layoutOrder
    Button.Parent = Container
    
    local BtnCorner = Instance.new("UICorner", Button)
    BtnCorner.CornerRadius = UDim.new(0, 4)
    
    local BtnStroke = Instance.new("UIStroke", Button)
    BtnStroke.Color = Color3.fromRGB(50, 20, 90)
    BtnStroke.Thickness = 1
    
    -- Visual interaction feedbacks
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 12, 60)}):Play()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Color3 = Color3.fromRGB(180, 80, 255)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(16, 8, 28)}):Play()
        TweenService:Create(BtnStroke, TweenInfo.new(0.2), {Color3 = Color3.fromRGB(50, 20, 90)}):Play()
    end)
    
    Button.MouseButton1Click:Connect(callback)
    return Button
end

-- 7. DEFINE EXECUTABLE HOOKS
CreateFeatureButton("ESP Framework (Show Murderer / Sheriff)", 1, function()
    print("[Cosmic Engine]: Initializing MM2 Role ESP...")
    -- Place your custom MM2 ESP iteration framework loop here
end)

CreateFeatureButton("Autofarm System (Collect Coins)", 2, function()
    print("[Cosmic Engine]: Teleporting to map coin layers...")
    -- Place your custom tween / coin position monitoring function here
end)

CreateFeatureButton("Gun Grabber (Auto Pickup Drop)", 3, function()
    print("[Cosmic Engine]: Monitoring map workspace for dropped Sheriff gun...")
    -- Place your dropped gun tracking vector loop here
end)

CreateFeatureButton("Kill Aura Framework (Modulated)", 4, function()
    print("[Cosmic Engine]: Activating structural hitbox expansion parameters...")
    -- Place your target frame magnitude inspection adjustments here
end)
