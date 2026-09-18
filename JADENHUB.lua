-- =====================================================================
-- 👑 JADENHUB V6.17 - ALL ⚡ CHANGED TO 👑 👑
-- =====================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = Players.LocalPlayer

local playerGui = LocalPlayer:WaitForChild("PlayerGui")
if playerGui:FindFirstChild("JadenHubV6") then playerGui.JadenHubV6:Destroy() end
if playerGui:FindFirstChild("JadenHubMiniUI") then playerGui.JadenHubMiniUI:Destroy() end

if not _G.JadenHubTags then _G.JadenHubTags = {} end

local createMainUI
local createMiniUI

local function applyTag(targetPlayer, text, color, animStyle)
    local char = targetPlayer.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end
    
    if head:FindFirstChild("JadenTagGui") then head.JadenTagGui:Destroy() end
    
    local bg = Instance.new("BillboardGui")
    bg.Name = "JadenTagGui"
    bg.Size = UDim2.new(0, 220, 0, 60)
    bg.StudsOffset = Vector3.new(0, 3, 0)
    bg.AlwaysOnTop = true
    bg.MaxDistance = 60
    bg.Parent = head
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextSize = 22
    lbl.Font = Enum.Font.GothamBlack
    lbl.Parent = bg
    
    task.spawn(function()
        local start = tick()
        while bg and bg.Parent do
            local dt = tick() - start
            if color == "Rainbow" then
                lbl.TextColor3 = Color3.fromHSV((dt % 5) / 5, 0.9, 1)
            else
                lbl.TextColor3 = color
            end
            
            if animStyle == "Bounce" then
                bg.StudsOffset = Vector3.new(0, 3 + math.sin(dt * 2.2) * 0.15, 0)
                lbl.Rotation = 0
            elseif animStyle == "Pulse" then
                bg.StudsOffset = Vector3.new(0, 3, 0)
                local scaleFactor = 1 + math.sin(dt * 3.5) * 0.1
                lbl.Size = UDim2.new(scaleFactor, 0, scaleFactor, 0)
                lbl.Position = UDim2.new((1 - scaleFactor) / 2, 0, (1 - scaleFactor) / 2, 0)
                lbl.Rotation = 0
            elseif animStyle == "Spin" then
                bg.StudsOffset = Vector3.new(0, 3, 0)
                lbl.Rotation = math.sin(dt * 2.5) * 10
            else
                bg.StudsOffset = Vector3.new(0, 3, 0)
                lbl.Rotation = 0
            end
            RunService.RenderStepped:Wait()
        end
    end)
end

-- Persistent tag monitor for respawns/resets
local function setupCharacterHook(p)
    p.CharacterAdded:Connect(function(c)
        task.wait(0.6)
        if _G.JadenHubTags[p] then
            local data = _G.JadenHubTags[p]
            applyTag(p, data.Text, data.Color, data.Anim)
        end
    end)
end

Players.PlayerAdded:Connect(setupCharacterHook)
for _, p in ipairs(Players:GetPlayers()) do
    setupCharacterHook(p)
    if _G.JadenHubTags[p] and p.Character then
        applyTag(p, _G.JadenHubTags[p].Text, _G.JadenHubTags[p].Color, _G.JadenHubTags[p].Anim)
    end
end

createMiniUI = function()
    pcall(function()
        local pg = LocalPlayer:WaitForChild("PlayerGui")
        if pg:FindFirstChild("JadenHubMiniUI") then return end

        local miniGui = Instance.new("ScreenGui")
        miniGui.Name = "JadenHubMiniUI"
        miniGui.ResetOnSpawn = false
        miniGui.Parent = pg

        local openBtn = Instance.new("TextButton")
        openBtn.Size = UDim2.new(0, 42, 0, 42)
        openBtn.Position = UDim2.new(0, 10, 0.5, -21)
        openBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
        openBtn.Text = "👑"
        openBtn.TextColor3 = Color3.fromRGB(0, 242, 255)
        openBtn.TextSize = 18
        openBtn.Font = Enum.Font.GothamBlack
        openBtn.Parent = miniGui

        Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)
        local stroke = Instance.new("UIStroke", openBtn)
        stroke.Color = Color3.fromRGB(0, 242, 255)
        stroke.Thickness = 2

        openBtn.MouseButton1Click:Connect(function()
            miniGui:Destroy()
            createMainUI()
        end)
    end)
end

createMainUI = function()
    pcall(function()
        local pg = LocalPlayer:WaitForChild("PlayerGui")
        if pg:FindFirstChild("JadenHubV6") then pg.JadenHubV6:Destroy() end

        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "JadenHubV6"
        screenGui.ResetOnSpawn = false
        screenGui.Parent = pg

        local main = Instance.new("Frame")
        main.Size = UDim2.new(0, 260, 0, 440)
        -- Positioned low enough to clear the Roblox menu bar
        main.Position = UDim2.new(0.5, -35, 0.5, -210)
        main.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
        main.BorderSizePixel = 0
        main.Parent = screenGui

        Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
        local mainStroke = Instance.new("UIStroke", main)
        mainStroke.Color = Color3.fromRGB(0, 242, 255)
        mainStroke.Thickness = 1.5

        -- Header Top Bar
        local top = Instance.new("Frame")
        top.Size = UDim2.new(1, 0, 0, 36)
        top.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
        top.BorderSizePixel = 0
        top.ZIndex = 10
        top.Parent = main

        Instance.new("UICorner", top).CornerRadius = UDim.new(0, 10)

        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -75, 1, 0)
        title.Position = UDim2.new(0, 10, 0, 0)
        title.BackgroundTransparency = 1
        title.Text = "👑 JADENHUB"
        title.TextColor3 = Color3.fromRGB(0, 242, 255)
        title.TextSize = 12
        title.Font = Enum.Font.GothamBlack
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.ZIndex = 11
        title.Parent = top

        -- 🗑️ Trash Button
        local unmainBtn = Instance.new("TextButton")
        unmainBtn.Size = UDim2.new(0, 26, 0, 26)
        unmainBtn.Position = UDim2.new(1, -58, 0, 5)
        unmainBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 25)
        unmainBtn.Text = "🗑"
        unmainBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
        unmainBtn.TextSize, unmainBtn.Font = 12, Enum.Font.GothamBold
        unmainBtn.ZIndex = 12
        unmainBtn.Parent = top
        Instance.new("UICorner", unmainBtn).CornerRadius = UDim.new(0, 6)

        unmainBtn.MouseButton1Click:Connect(function()
            if pg:FindFirstChild("JadenHubMiniUI") then pg.JadenHubMiniUI:Destroy() end
            screenGui:Destroy()
        end)

        -- ❌ X Button
        local closeBtn = Instance.new("TextButton")
        closeBtn.Size = UDim2.new(0, 26, 0, 26)
        closeBtn.Position = UDim2.new(1, -29, 0, 5)
        closeBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        closeBtn.Text = "✕"
        closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeBtn.TextSize, closeBtn.Font = 12, Enum.Font.GothamBold
        closeBtn.ZIndex = 12
        closeBtn.Parent = top
        Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

        closeBtn.MouseButton1Click:Connect(function()
            screenGui:Destroy()
            createMiniUI()
        end)

        -- Dragging Support
        local dragging, dragStart, startPos
        top.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = main.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)

        -- Content Frame
        local content = Instance.new("ScrollingFrame")
        content.Size = UDim2.new(1, -16, 1, -45)
        content.Position = UDim2.new(0, 8, 0, 42)
        content.BackgroundTransparency = 1
        content.CanvasSize = UDim2.new(0, 0, 0, 480)
        content.ScrollBarThickness = 2
        content.Parent = main

        local currentTarget = LocalPlayer
        local currentTagText = "OWNER"
        local currentColor = "Rainbow"
        local currentAnim = "Bounce"

        local function createDropdown(name, defaultText, items, onSelect)
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, 0, 0, 14)
            lbl.BackgroundTransparency = 1
            lbl.Text = name
            lbl.TextColor3 = Color3.fromRGB(0, 229, 255)
            lbl.TextSize = 10
            lbl.Font = Enum.Font.GothamBold
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = content

            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 26)
            btn.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
            btn.Text = "  " .. defaultText
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.TextSize, btn.TextXAlignment = 10, Enum.TextXAlignment.Left
            btn.Font = Enum.Font.GothamSemibold
            btn.Parent = content
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

            local list = Instance.new("ScrollingFrame")
            list.Size = UDim2.new(1, 0, 0, 90)
            list.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
            list.BorderSizePixel = 0
            list.Visible = false
            list.ZIndex = 5
            list.CanvasSize = UDim2.new(0, 0, 0, 0)
            list.ScrollBarThickness = 2
            list.Parent = content
            Instance.new("UICorner", list).CornerRadius = UDim.new(0, 6)

            local function refreshList()
                for _, child in ipairs(list:GetChildren()) do
                    if child:IsA("TextButton") then child:Destroy() end
                end
                local y = 0
                local currentItems = (type(items) == "function") and items() or items
                for _, item in ipairs(currentItems) do
                    local itemBtn = Instance.new("TextButton")
                    itemBtn.Size = UDim2.new(1, 0, 0, 24)
                    itemBtn.Position = UDim2.new(0, 0, 0, y)
                    itemBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
                    itemBtn.Text = "  " .. (item.Text or tostring(item))
                    itemBtn.TextColor3 = Color3.fromRGB(220, 220, 240)
                    itemBtn.TextSize, itemBtn.TextXAlignment = 10, Enum.TextXAlignment.Left
                    itemBtn.Font = Enum.Font.GothamMedium
                    itemBtn.ZIndex = 6
                    itemBtn.Parent = list
                    
                    itemBtn.MouseButton1Click:Connect(function()
                        btn.Text = "  " .. (item.Text or tostring(item))
                        list.Visible = false
                        onSelect(item.Value or item)
                    end)
                    y = y + 24
                end
                list.CanvasSize = UDim2.new(0, 0, 0, y)
            end

            btn.MouseButton1Click:Connect(function()
                list.Visible = not list.Visible
                if list.Visible then
                    refreshList()
                    list.Position = UDim2.new(0, 0, 0, btn.Position.Y.Offset + 30)
                end
            end)

            return btn
        end

        createDropdown("TARGET PLAYER:", LocalPlayer.Name .. " (@" .. LocalPlayer.DisplayName .. ")", function()
            local t = {}
            for _, p in ipairs(Players:GetPlayers()) do
                local labelText = p.Name .. " (@" .. p.DisplayName .. ")"
                table.insert(t, {Text = labelText, Value = p})
            end
            return t
        end, function(selected) currentTarget = selected end)

        createDropdown("TAG TEXT:", "OWNER", {"OWNER", "ADMIN", "👑 CREATOR 👑", "VIP", "GOD"}, function(selected) currentTagText = selected end)

        createDropdown("TAG COLOR:", "Rainbow", {
            {Text = "Rainbow", Value = "Rainbow"},
            {Text = "Red", Value = Color3.fromRGB(255, 80, 80)},
            {Text = "Green", Value = Color3.fromRGB(80, 255, 120)},
            {Text = "Blue", Value = Color3.fromRGB(80, 160, 255)},
            {Text = "Yellow", Value = Color3.fromRGB(255, 230, 80)},
            {Text = "Cyan", Value = Color3.fromRGB(80, 255, 255)},
            {Text = "Pink", Value = Color3.fromRGB(255, 100, 200)},
            {Text = "White", Value = Color3.fromRGB(255, 255, 255)}
        }, function(selected) currentColor = selected end)

        createDropdown("ANIMATION:", "Bounce", {"Bounce", "Pulse", "Spin", "None"}, function(selected) currentAnim = selected end)

        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 6)
        layout.Parent = content

        local actionContainer = Instance.new("Frame")
        actionContainer.Size = UDim2.new(1, 0, 0, 65)
        actionContainer.BackgroundTransparency = 1
        actionContainer.Parent = content

        local applyBtn = Instance.new("TextButton")
        applyBtn.Size = UDim2.new(1, 0, 0, 28)
        applyBtn.Position = UDim2.new(0, 0, 0, 2)
        applyBtn.BackgroundColor3 = Color3.fromRGB(0, 229, 255)
        applyBtn.Text = "👑 APPLY TAG"
        applyBtn.TextColor3 = Color3.fromRGB(12, 12, 18)
        applyBtn.TextSize, applyBtn.Font = 11, Enum.Font.GothamBlack
        applyBtn.Parent = actionContainer
        Instance.new("UICorner", applyBtn).CornerRadius = UDim.new(0, 6)

        applyBtn.MouseButton1Click:Connect(function()
            if currentTarget and currentTarget.Parent then
                _G.JadenHubTags[currentTarget] = {Text = currentTagText, Color = currentColor, Anim = currentAnim}
                applyTag(currentTarget, currentTagText, currentColor, currentAnim)
            end
        end)

        local removeBtn = Instance.new("TextButton")
        removeBtn.Size = UDim2.new(1, 0, 0, 28)
        removeBtn.Position = UDim2.new(0, 0, 0, 34)
        removeBtn.BackgroundColor3 = Color3.fromRGB(45, 30, 40)
        removeBtn.Text = "🗑️ REMOVE TAG"
        removeBtn.TextColor3 = Color3.fromRGB(255, 120, 120)
        removeBtn.TextSize, removeBtn.Font = 11, Enum.Font.GothamBlack
        removeBtn.Parent = actionContainer
        Instance.new("UICorner", removeBtn).CornerRadius = UDim.new(0, 6)

        removeBtn.MouseButton1Click:Connect(function()
            if currentTarget then
                _G.JadenHubTags[currentTarget] = nil
                local char = currentTarget.Character
                if char and char:FindFirstChild("Head") and char.Head:FindFirstChild("JadenTagGui") then
                    char.Head.JadenTagGui:Destroy()
                end
            end
        end)

        -- 📱 Social Accounts Section Header
        local socialHeader = Instance.new("TextLabel")
        socialHeader.Size = UDim2.new(1, 0, 0, 18)
        socialHeader.BackgroundTransparency = 1
        socialHeader.Text = "📱 SOCIAL ACCOUNTS"
        socialHeader.TextColor3 = Color3.fromRGB(0, 229, 255)
        socialHeader.TextSize = 10
        socialHeader.Font = Enum.Font.GothamBold
        socialHeader.TextXAlignment = Enum.TextXAlignment.Left
        socialHeader.Parent = content

        -- 🎮 Roblox User Button
        local robloxBtn = Instance.new("TextButton")
        robloxBtn.Size = UDim2.new(1, 0, 0, 28)
        robloxBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        robloxBtn.Text = "  Roblox User: MRJADEN"
        robloxBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        robloxBtn.TextSize, robloxBtn.TextXAlignment = 10, Enum.TextXAlignment.Left
        robloxBtn.Font = Enum.Font.GothamSemibold
        robloxBtn.Parent = content
        Instance.new("UICorner", robloxBtn).CornerRadius = UDim.new(0, 6)

        robloxBtn.MouseButton1Click:Connect(function()
            pcall(function()
                setclipboard("MRJADEN")
            end)
            robloxBtn.Text = "  ✓ Copied Roblox Username!"
            task.wait(1.5)
            robloxBtn.Text = "  Roblox User: MRJADEN"
        end)

        -- 💬 Discord Button
        local discordBtn = Instance.new("TextButton")
        discordBtn.Size = UDim2.new(1, 0, 0, 28)
        discordBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        discordBtn.Text = "  Discord: discord.gg/bhfJys73d"
        discordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        discordBtn.TextSize, discordBtn.TextXAlignment = 10, Enum.TextXAlignment.Left
        discordBtn.Font = Enum.Font.GothamSemibold
        discordBtn.Parent = content
        Instance.new("UICorner", discordBtn).CornerRadius = UDim.new(0, 6)

        discordBtn.MouseButton1Click:Connect(function()
            pcall(function()
                setclipboard("discord.gg/bhfJys73d")
            end)
            discordBtn.Text = "  ✓ Copied Discord Link!"
            task.wait(1.5)
            discordBtn.Text = "  Discord: discord.gg/bhfJys73d"
        end)

        -- 🎵 TikTok Button
        local tiktokBtn = Instance.new("TextButton")
        tiktokBtn.Size = UDim2.new(1, 0, 0, 28)
        tiktokBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        tiktokBtn.Text = "  Tiktok: lalamojaden2"
        tiktokBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tiktokBtn.TextSize, tiktokBtn.TextXAlignment = 10, Enum.TextXAlignment.Left
        tiktokBtn.Font = Enum.Font.GothamSemibold
        tiktokBtn.Parent = content
        Instance.new("UICorner", tiktokBtn).CornerRadius = UDim.new(0, 6)

        tiktokBtn.MouseButton1Click:Connect(function()
            pcall(function()
                setclipboard("lalamojaden2")
            end)
            tiktokBtn.Text = "  ✓ Copied Tiktok Handle!"
            task.wait(1.5)
            tiktokBtn.Text = "  Tiktok: lalamojaden2"
        end)

        content.CanvasSize = UDim2.new(0, 0, 0, 520)
    end)
end

local function triggerOpen()
    local pg = LocalPlayer:WaitForChild("PlayerGui")
    if not pg:FindFirstChild("JadenHubV6") then
        if pg:FindFirstChild("JadenHubMiniUI") then pg.JadenHubMiniUI:Destroy() end
        createMainUI()
    end
end

if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
    task.spawn(function()
        TextChatService.OnIncomingMessage = function(message)
            if message.TextSource and message.TextSource.UserId == LocalPlayer.UserId then
                local contentLower = string.lower(message.Text)
                if contentLower:find("jadenhub") then
                    triggerOpen()
                    local mutableProperties = Instance.new("TextChatMessageProperties")
                    mutableProperties.Text = ""
                    return mutableProperties
                end
            end
        end
    end)
end

LocalPlayer.Chatted:Connect(function(msg)
    if string.lower(msg):find("jadenhub") then
        triggerOpen()
    end
end)

createMainUI()
