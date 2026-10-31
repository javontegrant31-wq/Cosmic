-- MM2 Cosmic GUI Engine (Combat, Lock & Minimize Edition)
-- Theme: Pitch Black Void, Violet Cosmic Energy, Anime Silhouette

local Player = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

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
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true 
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

-- Starfield Generator
for i = 1, 45 do
    local Star = Instance.new("Frame")
    Star.Size = UDim2.new(0, math.random(1, 3), 0, math.random(1, 3))
    Star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    Star.BackgroundColor3 = Color3.fromRGB(230, 210, 255)
    Star.BorderSizePixel = 0
    Star.BackgroundTransparency = math.random(2, 6) / 10
    Star.Parent = Background
    
    RunService.RenderStepped:Connect(function()
        Star.BackgroundTransparency = 0.4 + 0.3 * math.sin(tick() + i * 2)
    end)
end

-- 4. HEADER BAR & NAVIGATION CONTROLS
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 160, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "COSMIC MM2 ENGINE"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextColor3 = Color3.fromRGB(220, 180, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = Header

-- Lock Position Button
local LockBtn = Instance.new("TextButton")
LockBtn.Size = UDim2.new(0, 90, 0, 24)
LockBtn.Position = UDim2.new(1, -210, 0.5, -12)
LockBtn.BackgroundColor3 = Color3.fromRGB(30, 10, 50)
LockBtn.Text = "🔓 Moveable"
LockBtn.Font = Enum.Font.GothamBold
LockBtn.TextSize = 10
LockBtn.TextColor3 = Color3.fromRGB(200, 150, 255)
LockBtn.Parent = Header
Instance.new("UICorner", LockBtn).CornerRadius = UDim.new(0, 4)

local isLocked = false
LockBtn.MouseButton1Click:Connect(function()
    isLocked = not isLocked
    MainFrame.Draggable = not isLocked
    if isLocked then
        LockBtn.Text = "🔒 Locked"
        LockBtn.BackgroundColor3 = Color3.fromRGB(70, 15, 30)
        LockBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    else
        LockBtn.Text = "🔓 Moveable"
        LockBtn.BackgroundColor3 = Color3.fromRGB(30, 10, 50)
        LockBtn.TextColor3 = Color3.fromRGB(200, 150, 255)
    end
end)

-- 5. MINIMIZE COMPACT WINDOW MANAGER
local MiniFrame = Instance.new("TextButton")
MiniFrame.Name = "MiniFrame"
MiniFrame.Size = UDim2.new(0, 50, 0, 50)
MiniFrame.Position = UDim2.new(0, 20, 0, 20)
MiniFrame.BackgroundColor3 = Color3.fromRGB(15, 5, 30)
MiniFrame.Text = "🌌"
MiniFrame.TextSize = 22
MiniFrame.Visible = false
MiniFrame.Active = true
MiniFrame.Draggable = true
MiniFrame.Parent = ScreenGui

local MiniStroke = Instance.new("UIStroke", MiniFrame)
MiniStroke.Thickness = 2
MiniStroke.Color = Color3.fromRGB(150, 40, 255)

Instance.new("UICorner", MiniFrame).CornerRadius = UDim.new(0, 25)

-- Minimize Trigger Action Button
local MiniBtn = Instance.new("TextButton")
MiniBtn.Size = UDim2.new(0, 30, 0, 30)
MiniBtn.Position = UDim2.new(1, -110, 0.5, -15)
MiniBtn.Text = "🗕"
MiniBtn.Font = Enum.Font.GothamBold
MiniBtn.TextSize = 14
MiniBtn.TextColor3 = Color3.fromRGB(200, 150, 255)
MiniBtn.BackgroundTransparency = 1
MiniBtn.Parent = Header

MiniBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MiniFrame.Position = UDim2.new(0, MainFrame.AbsolutePosition.X + 20, 0, MainFrame.AbsolutePosition.Y + 20)
    MiniFrame.Visible = true
end)

MiniFrame.MouseButton1Click:Connect(function()
    MiniFrame.Visible = false
    MainFrame.Position = UDim2.new(0, MiniFrame.AbsolutePosition.X - 20, 0, MiniFrame.AbsolutePosition.Y - 20)
    MainFrame.Visible = true
end)

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

-- 6. SCROLLING BUTTON CONTAINER
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

-- 7. ESP FRAMEWORK CONFIG
local espEnabled = false
local function ApplyESP(player, color)
    if player == Player or not player.Character then return end
    if player.Character:FindFirstChild("CosmicHighlight") then
        player.Character.CosmicHighlight:Destroy()
    end
    if espEnabled then
        local Highlight = Instance.new("Highlight")
        Highlight.Name = "CosmicHighlight"
        Highlight.FillColor = color
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        Highlight.FillTransparency = 0.4
        Highlight.Adornee = player.Character
        Highlight.Parent = player.Character
    end
end

CreateFeatureButton("Toggle ESP Framework", 1, function()
    espEnabled = not espEnabled
    if not espEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("CosmicHighlight") then
                p.Character.CosmicHighlight:Destroy()
            end
        end
        return
    end
    task.spawn(function()
        while espEnabled and task.wait(1) do
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character then
                    local color = Color3.fromRGB(0, 255, 0)
                    if p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife") then
                        color = Color3.fromRGB(255, 0, 0)
                    elseif p.Backpack:FindFirstChild("Gun") or p.Character:FindFirstChild("Gun") then
                        color = Color3.fromRGB(0, 0, 255)
                    end
                    ApplyESP(p, color)
                end
            end
        end
    end)
end)

-- 8. AUTO-SHOOT MURDERER LOGIC ENGINE
local autoShootEnabled = false

local function FindMurderer()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            if p.Backpack:FindFirstChild("Knife") or p.Character:FindFirstChild("Knife") then
                return p.Character.HumanoidRootPart
            end
        end
    end
    return nil
end

CreateFeatureButton("Toggle Auto-Shoot Murderer", 2, function()
    autoShootEnabled = not autoShootEnabled
    if autoShootEnabled then
        task.spawn(function()
            while autoShootEnabled and task.wait(0.1) do
                local Gun = Player.Character and (Player.Character:FindFirstChild("Gun") or Player.Backpack:FindFirstChild("Gun"))
