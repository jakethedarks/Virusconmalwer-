local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local lighting = game:GetService("Lighting")
local replicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local coreGui = game:GetService("CoreGui")
local localPlayer = players.LocalPlayer
local v2 = false
_G.FriendColor = Color3.fromRGB(0, 0, 255)
_G.EnemyColor  = Color3.fromRGB(255, 0, 0)
_G.UseTeamColor = true

local humanoid = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild("Humanoid")
if not _G.Walkspeed then _G.Walkspeed = humanoid.WalkSpeed end
if not _G.loopW     then _G.loopW = false end
if not _G.TPSpeed   then _G.TPSpeed = 1 end
if not _G.TPWalk    then _G.TPWalk = false end

getgenv().Walkspeed = _G.Walkspeed
getgenv().loopW     = _G.loopW
getgenv().TPSpeed   = _G.TPSpeed
getgenv().TPWalk    = _G.TPWalk

local v5 = {}

local v6 = {
    "Crxsyx","LaCoquette6_2","dewn_sz","KayKayRirisangel","nadmire_JL",
    "Fyro_190","Msky_nlh","Zdiogobreno042","diogobreno0421","Ikaris_BR",
    "rosado289","grancheroka_br","ShingekiNoKyojin_17","lIIllIllllIIIlIlIlII",
    "lIIllIllllIIIlIlIlI","lIIllIllllIIIlIlIll","lIIllIllllIIIlIlII",
    "lIIllIllllIIIlIlIl","Lily_2008063","Purarisa0","Gatitblox",
    "angeIovers","An_uelAA1","Lily_123nsw","MYNAMEISJEFF711",
    "LaPuchainaaaa6","mmelii_rdz","lilianhofttee","Alex2g36",
    "darkissoez","darkissoez1","darkissoez2","darkissoez3","darkissoez4",
    "darkissoez5","darkissoez6","darkissoez7","darkissoez8","darkissoez9",
    "darkissoez10","darkissoez11","darkissoez12","darkissoez13",
    "darkissoez14","darkissoez15","darkissoez16","darkissoez17",
    "botfuerte1","botfuerte2","botfuerte3","botfuerte4","botfuerte5",
    "botfuerte6","botfuerte7","botfuerte8","botfuerte9","botfuerte10",
    "botfuerte11","botfuerte12","botfuerte13","cuffedoll","bloodalt2020",
    "crxsyx121","serranito206","Backpackboy40","Belt_kim","mmaria_207",
    "rotto44","trunksalexzander123","xxdeidaraxx50","ikanaide08",
    "naoshecid0108","Mailu_7500",
}

local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid2 = character:WaitForChild("Humanoid")
local rootPart = humanoid2.RootPart

local v9 = {
    ["Estático"] = {
        DepthStuds = 6000,
        VerticalOffset = Vector3.new(0, -6000, 0),
        ApplyRotation = true,
        RotationCFrame = CFrame.Angles(0, 0, math.rad(180)),
        Description = "6000 studs, boca abajo",
    },
    Parpadeo = {
        DepthStuds = 300,
        VerticalOffset = Vector3.new(0, -300, 0),
        ApplyRotation = true,
        RotationCFrame = CFrame.Angles(0, 0, math.rad(180)),
        Description = "Parpadea cada 0.7s",
    },
    AntiHS = {
        DepthStuds = 4.5,
        VerticalOffset = Vector3.new(0, -4.5, 0),
        ApplyRotation = false,
        RotationCFrame = CFrame.identity,
        Description = "4.5 studs, de pie",
    },
}

local cframe = rootPart.CFrame
local v10 = false
local v11 = "Estático"
local v12 = {}
local v13 = {}

local highlight = Instance.new("Highlight")
highlight.Adornee = character
highlight.Enabled = true
highlight.FillColor = Color3.fromRGB(255, 255, 0)
highlight.OutlineColor = Color3.fromRGB(255, 200, 0)
highlight.FillTransparency = 0.5
highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
highlight.Parent = coreGui

local function f1()
    return "FakeStep_"..tostring(tick()).."_"..math.random(1000, 9999)
end

local function f2()
    for _, conn in ipairs(v12) do conn:Disconnect() end
    v12 = {}
    for _, name in ipairs(v13) do
        runService:UnbindFromRenderStep(name)
    end
    v13 = {}
end

local function f3()
    if not v10 then return end
    v10 = false
    f2()
    if rootPart then
        rootPart.CFrame = cframe
    end
end

local function f4(p1)
    if v10 then return end
    local estTico = v9[p1] or v9["Estático"]
    f2()
    v10 = true
    cframe = rootPart.CFrame

    local v14 = f1()
    local v15 = f1()

    runService:BindToRenderStep(v14, Enum.RenderPriority.Camera.Value - 5, function()
        if rootPart and v10 then
            rootPart.CFrame = cframe
        end
    end)
    table.insert(v13, v14)

    runService:BindToRenderStep(v15, Enum.RenderPriority.Camera.Value + 5, function()
        if rootPart and v10 then
            cframe = rootPart.CFrame
            local pos = rootPart.Position + estTico.VerticalOffset
            local newCf
            if estTico.ApplyRotation then
                newCf = CFrame.new(pos) * estTico.RotationCFrame
            else
                newCf = CFrame.new(pos) * (rootPart.CFrame - rootPart.Position)
            end
            rootPart.CFrame = newCf
        end
    end)
    table.insert(v13, v15)

    table.insert(v12, runService.PreAnimation:Connect(function()
        if rootPart and v10 then
            rootPart.CFrame = cframe
        end
    end))

    table.insert(v12, runService.PostSimulation:Connect(function()
        if rootPart and v10 then
            cframe = rootPart.CFrame
            local pos = rootPart.Position + estTico.VerticalOffset
            local newCf
            if estTico.ApplyRotation then
                newCf = CFrame.new(pos) * estTico.RotationCFrame
            else
                newCf = CFrame.new(pos) * (rootPart.CFrame - rootPart.Position)
            end
            rootPart.CFrame = newCf
        end
    end))
end

local function f5()
    if v10 then return end
    local parpadeo = v9.Parpadeo
    v10 = true
    task.spawn(function()
        while v10 and v11 == "Parpadeo" do
            f2()
            cframe = rootPart.CFrame
            local v20 = f1()
            local v21 = f1()

            runService:BindToRenderStep(v20, Enum.RenderPriority.Camera.Value - 5, function()
                if rootPart and v10 then rootPart.CFrame = cframe end
            end)
            table.insert(v13, v20)

            runService:BindToRenderStep(v21, Enum.RenderPriority.Camera.Value + 5, function()
                if rootPart and v10 then
                    cframe = rootPart.CFrame
                    rootPart.CFrame = CFrame.new(rootPart.Position + parpadeo.VerticalOffset) * parpadeo.RotationCFrame
                end
            end)
            table.insert(v13, v21)

            table.insert(v12, runService.PreAnimation:Connect(function()
                if rootPart and v10 then rootPart.CFrame = cframe end
            end))
            table.insert(v12, runService.PostSimulation:Connect(function()
                if rootPart and v10 then
                    cframe = rootPart.CFrame
                    rootPart.CFrame = CFrame.new(rootPart.Position + parpadeo.VerticalOffset) * parpadeo.RotationCFrame
                end
            end))

            task.wait(0.7)
            if not v10 or v11 ~= "Parpadeo" then break end
            f2()
            if rootPart then rootPart.CFrame = cframe end
            task.wait(0.1)
        end
    end)
end

localPlayer.CharacterAdded:Connect(function(character2)
    character = character2
    humanoid2 = character2:WaitForChild("Humanoid")
    rootPart = humanoid2.RootPart
    cframe = rootPart.CFrame
    highlight.Adornee = character
    if v10 then
        task.wait(0.1)
        v10 = false
        if v11 == "Parpadeo" then f5() else f4(v11) end
    end
end)

function _G.ToggleFakeInvis()
    if v10 then
        f3()
    elseif v11 == "Parpadeo" then
        f5()
    else
        f4(v11)
    end
end

function _G.ToggleFakeMode()
    local modes = { "Estático", "Parpadeo", "AntiHS" }
    local idx = 1
    for i, m in ipairs(modes) do
        if m == v11 then idx = i; break end
    end
    local wasOn = v10
    f3()
    v11 = modes[idx % #modes + 1]
    if wasOn then
        if v11 == "Parpadeo" then f5() else f4(v11) end
    end
    return v11
end

function _G.GetFakeMode() return v11 end
function _G.IsFakeInvisEnabled() return v10 end
function _G.GetModeDescription()
    return (v9[v11] or v9["Estático"]).Description
end

-- ESP
local instance
local function f6(p7)
    if not p7 then return false end
    local lower = p7.Name:lower()
    for _, n in ipairs(v6) do
        if lower == n:lower() then return true end
    end
    local lower2 = p7.DisplayName:lower()
    for _, n in ipairs(v6) do
        if lower2 == n:lower() then return true end
    end
    return false
end

local function f8(p3)
    if not p3 or p3 == localPlayer then return end
    if f6(p3) then return end
    if not v2 then return end

    if not instance or not instance.Parent then
        instance = Instance.new("Folder", game.CoreGui)
        instance.Name = "ESP_"..tostring(tick())
    end

    local folder = instance:FindFirstChild(p3.Name)
    if folder then
        folder:ClearAllChildren()
        folder:Destroy()
    end
    folder = Instance.new("Folder")
    folder.Name = p3.Name
    folder.Parent = instance
    v5[p3] = {}

    local function build(p4)
        if not p4 or not v2 then return end
        task.spawn(function()
            local hrp = p4:WaitForChild("HumanoidRootPart", 2)
            if not hrp then return end

            local box = Instance.new("BoxHandleAdornment")
            box.Name = "Box"
            box.Size = Vector3.new(4, 7, 4)
            box.Transparency = 0.7
            box.ZIndex = 0
            box.AlwaysOnTop = true
            box.Visible = true
            box.Adornee = hrp
            box.Parent = folder

            local nameTag = Instance.new("BillboardGui")
            nameTag.Name = "NameTag"
            nameTag.Enabled = true
            nameTag.Size = UDim2.new(0, 200, 0, 50)
            nameTag.AlwaysOnTop = true
            nameTag.StudsOffset = Vector3.new(0, 5, 0)
            nameTag.MaxDistance = 1000
            nameTag.Adornee = hrp
            nameTag.Parent = folder

            local tag = Instance.new("TextLabel", nameTag)
            tag.Name = "Tag"
            tag.BackgroundTransparency = 1
            tag.Position = UDim2.new(0, -50, 0, 0)
            tag.Size = UDim2.new(0, 300, 0, 20)
            tag.TextSize = 22
            tag.TextStrokeColor3 = Color3.new(0, 0, 0)
            tag.TextStrokeTransparency = 0.4
            tag.Text = p3.Name
            tag.Font = Enum.Font.SourceSansBold
            tag.TextScaled = false

            local hl = Instance.new("Highlight")
            hl.Name = "Highlight"
            hl.Adornee = p4
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.FillTransparency = 0.5
            hl.OutlineTransparency = 0
            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            hl.Parent = folder

            if _G.UseTeamColor then
                box.Color3 = p3.TeamColor.Color
                tag.TextColor3 = p3.TeamColor.Color
                hl.FillColor = p3.TeamColor.Color
            else
                local color = (localPlayer.TeamColor == p3.TeamColor) and _G.FriendColor or _G.EnemyColor
                box.Color3 = color
                tag.TextColor3 = color
                hl.FillColor = color
            end
        end)
    end

    if p3.Character then build(p3.Character) end
    local conn = p3.CharacterAdded:Connect(function(c)
        task.wait(0.5)
        if v2 and folder.Parent then build(c) end
    end)
    v5[p3].charConnection = conn
    v5[p3].vHolder = folder
end

local function f10(p5)
    if v5[p5] then
        if v5[p5].charConnection then v5[p5].charConnection:Disconnect() end
        v5[p5] = nil
    end
    if instance and instance.Parent then
        local f = instance:FindFirstChild(p5.Name)
        if f then f:ClearAllChildren(); f:Destroy() end
    end
end

local connect2
local function f12()
    v2 = not v2
    if v2 then
        print("Activando ESP...")
        if instance and instance.Parent then instance:Destroy() end
        instance = Instance.new("Folder", game.CoreGui)
        instance.Name = "ESP_"..tostring(tick())
        for _, p in pairs(players:GetPlayers()) do
            if p ~= localPlayer and not f6(p) then f8(p) end
        end
        connect2 = players.PlayerAdded:Connect(function(p)
            if not f6(p) then f8(p) end
        end)
        return "ESP Activado"
    end
    print("Desactivando ESP...")
    if connect2 then connect2:Disconnect(); connect2 = nil end
    for _, info in pairs(v5) do
        if info.charConnection then info.charConnection:Disconnect() end
    end
    v5 = {}
    if instance then
        instance:ClearAllChildren()
        instance:Destroy()
        instance = nil
    end
    return "ESP Desactivado"
end

-- Loop WS
runService.Heartbeat:Connect(function()
    if getgenv().loopW then
        pcall(function()
            local c = localPlayer.Character
            if c and c:FindFirstChild("Humanoid") then
                c.Humanoid.WalkSpeed = getgenv().Walkspeed
            end
        end)
    end
end)

-- TP Walk
local function f11(p6)
    local v28 = math.max(1.5 + 148.5 * ((p6 - 1) / 49), 1.5)
    return math.round(v28 * 100) / 100
end

runService.Heartbeat:Connect(function()
    if not getgenv().TPWalk then return end
    local c = localPlayer.Character
    if not c then return end
    local h = c:FindFirstChild("Humanoid")
    if not h then return end
    if h.MoveDirection.Magnitude > 0 then
        local mult = f11(getgenv().TPSpeed)
        c:TranslateBy(h.MoveDirection * (0.05 * mult))
    end
end)

-- Ventana
local function f13(p8, p9, p10)
    local w = p9 or 240
    local h = p10 or 430
    local mainFrames = localPlayer.PlayerGui:FindFirstChild("MainFrames") or Instance.new("ScreenGui")
    mainFrames.Name = "MainFrames"
    mainFrames.ResetOnSpawn = false
    mainFrames.Parent = localPlayer.PlayerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, w, 0, h)
    frame.Position = UDim2.new(0.5, -w/2, 0.5, -h/2)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = mainFrames

    local uc = Instance.new("UICorner"); uc.CornerRadius = UDim.new(0, 9); uc.Parent = frame
    local ug = Instance.new("UIGradient")
    ug.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30,30,30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10,10,10)),
    })
    ug.Rotation = 90
    ug.Parent = frame
    local us = Instance.new("UIStroke")
    us.Color = Color3.fromRGB(255,255,255); us.Transparency = 0.4; us.Thickness = 1.1
    us.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    us.Parent = frame

    local dragFrame = Instance.new("Frame")
    dragFrame.Name = "DragFrame"
    dragFrame.Size = UDim2.new(1,0,1,0)
    dragFrame.BackgroundTransparency = 1
    dragFrame.Active = true
    dragFrame.Selectable = false
    dragFrame.Parent = frame

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1,0,0,30)
    header.BackgroundTransparency = 1
    header.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.7,0,1,0)
    title.Position = UDim2.new(0,9,0,0)
    title.BackgroundTransparency = 1
    title.Text = p8 or "Diogo Br"
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.TextSize = 15
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header

    local btnMin = Instance.new("TextButton")
    btnMin.Size = UDim2.new(0,26,0,26)
    btnMin.Position = UDim2.new(1,-60,0,2)
    btnMin.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btnMin.Text = "-"
    btnMin.TextColor3 = Color3.fromRGB(200,200,200)
    btnMin.Font = Enum.Font.GothamBold
    btnMin.TextSize = 18
    btnMin.Parent = header
    local c1 = Instance.new("UICorner"); c1.CornerRadius = UDim.new(0,6); c1.Parent = btnMin

    local btnClose = Instance.new("TextButton")
    btnClose.Size = UDim2.new(0,26,0,26)
    btnClose.Position = UDim2.new(1,-32,0,2)
    btnClose.BackgroundColor3 = Color3.fromRGB(180,40,40)
    btnClose.Text = "X"
    btnClose.TextColor3 = Color3.fromRGB(255,220,220)
    btnClose.Font = Enum.Font.GothamBold
    btnClose.TextSize = 17
    btnClose.Parent = header
    local c2 = Instance.new("UICorner"); c2.CornerRadius = UDim.new(0,6); c2.Parent = btnClose

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1,0,1,-30)
    content.Position = UDim2.new(0,0,0,30)
    content.BackgroundTransparency = 1
    content.Parent = frame

    local minimized = false
    btnMin.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            frame.Size = UDim2.new(0,w,0,30)
            btnMin.Text = "+"
            btnMin.TextColor3 = Color3.fromRGB(100,255,100)
            content.Visible = false
        else
            frame.Size = UDim2.new(0,w,0,h)
            btnMin.Text = "-"
            btnMin.TextColor3 = Color3.fromRGB(200,200,200)
            content.Visible = true
        end
    end)

    btnClose.MouseButton1Click:Connect(function()
        if connect2 then connect2:Disconnect() end
        v2 = false
        for _, info in pairs(v5) do
            if info.charConnection then info.charConnection:Disconnect() end
        end
        v5 = {}
        if instance then instance:Destroy() end
        local qp = localPlayer.PlayerGui:FindFirstChild("MainFrames")
        if qp then
            local q = qp:FindFirstChild("QuickPanel")
            if q then q:Destroy() end
        end
        frame:Destroy()
    end)

    -- Drag (con fix: Enum.UserInputState.Begin)
    local dragging = false
    local startPos, startFrame
    local function startDrag(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startPos = input.Position
            startFrame = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end
    local function updateDrag(input)
        if dragging and startPos then
            local d = input.Position - startPos
            frame.Position = UDim2.new(
                startFrame.X.Scale, startFrame.X.Offset + d.X,
                startFrame.Y.Scale, startFrame.Y.Offset + d.Y
            )
        end
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            local target = input.UserInputState == Enum.UserInputState.Begin
                and userInputService:GetMouseTarget()
            if target then
                local p = target
                local isButton = false
                while p and p ~= frame do
                    if p:IsA("TextButton") or p:IsA("TextBox") then
                        isButton = true
                        break
                    end
                    p = p.Parent
                end
                if not isButton then startDrag(input) end
            else
                startDrag(input)
            end
        end
    end)
    frame.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            updateDrag(input)
        end
    end)
    dragFrame.InputBegan:Connect(startDrag)
    dragFrame.InputChanged:Connect(updateDrag)
    userInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            startPos = nil
        end
    end)

    return content, frame
end

local parent2, v37 = f13("Diogo Br - Alei💖", 240, 430)

-- Panel rápido
local quickPanel = Instance.new("Frame")
quickPanel.Name = "QuickPanel"
quickPanel.Size = UDim2.new(0,70,0,100)
quickPanel.Position = UDim2.new(0.5, 135, 0.5, -50)
quickPanel.BackgroundColor3 = Color3.fromRGB(20,20,20)
quickPanel.BackgroundTransparency = 0.1
quickPanel.BorderSizePixel = 0
quickPanel.Parent = localPlayer.PlayerGui:FindFirstChild("MainFrames")
local qc = Instance.new("UICorner"); qc.CornerRadius = UDim.new(0,8); qc.Parent = quickPanel
local qs = Instance.new("UIStroke")
qs.Color = Color3.fromRGB(255,255,255); qs.Transparency = 0.4; qs.Thickness = 1
qs.Parent = quickPanel

local qTitle = Instance.new("TextLabel")
qTitle.Size = UDim2.new(1,0,0,14)
qTitle.Position = UDim2.new(0,0,0,-14)
qTitle.BackgroundTransparency = 1
qTitle.Text = "ACCESO"
qTitle.TextColor3 = Color3.fromRGB(0,200,255)
qTitle.Font = Enum.Font.GothamBold
qTitle.TextSize = 9
qTitle.Parent = quickPanel

local btnInvis = Instance.new("TextButton")
btnInvis.Size = UDim2.new(0.86,0,0,28)
btnInvis.Position = UDim2.new(0.07,0,0,6)
btnInvis.BackgroundColor3 = Color3.fromRGB(30,30,30)
btnInvis.Text = "INVIS"
btnInvis.TextColor3 = Color3.fromRGB(255,255,100)
btnInvis.Font = Enum.Font.GothamBold
btnInvis.TextSize = 10
btnInvis.Parent = quickPanel
local ci1 = Instance.new("UICorner"); ci1.CornerRadius = UDim.new(0,4); ci1.Parent = btnInvis

local btnTpw = Instance.new("TextButton")
btnTpw.Size = UDim2.new(0.86,0,0,28)
btnTpw.Position = UDim2.new(0.07,0,0,36)
btnTpw.BackgroundColor3 = Color3.fromRGB(30,30,30)
btnTpw.Text = "TPW"
btnTpw.TextColor3 = Color3.fromRGB(100,255,255)
btnTpw.Font = Enum.Font.GothamBold
btnTpw.TextSize = 10
btnTpw.Parent = quickPanel
local ci2 = Instance.new("UICorner"); ci2.CornerRadius = UDim.new(0,4); ci2.Parent = btnTpw

local btnEsp = Instance.new("TextButton")
btnEsp.Size = UDim2.new(0.86,0,0,28)
btnEsp.Position = UDim2.new(0.07,0,0,66)
btnEsp.BackgroundColor3 = Color3.fromRGB(30,30,30)
btnEsp.Text = "ESP"
btnEsp.TextColor3 = Color3.fromRGB(255,80,80)
btnEsp.Font = Enum.Font.GothamBold
btnEsp.TextSize = 10
btnEsp.Parent = quickPanel
local ci3 = Instance.new("UICorner"); ci3.CornerRadius = UDim.new(0,4); ci3.Parent = btnEsp

-- Drag helper reutilizable
local function f16(p13)
    local dragging, startPos, startFrame
    p13.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startPos = i.Position
            startFrame = p13.Position
        end
    end)
    p13.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
            or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - startPos
            p13.Position = UDim2.new(
                startFrame.X.Scale, startFrame.X.Offset + d.X,
                startFrame.Y.Scale, startFrame.Y.Offset + d.Y
            )
        end
    end)
    userInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end
f16(v37)
f16(quickPanel)

-- Botones principales
local btnESP = Instance.new("TextButton")
btnESP.Size = UDim2.new(0.9,0,0,30)
btnESP.Position = UDim2.new(0.05,0,0.03,0)
btnESP.BackgroundColor3 = Color3.fromRGB(30,30,30)
btnESP.Text = "ESP: OFF"
btnESP.TextColor3 = Color3.fromRGB(255,80,80)
btnESP.Font = Enum.Font.GothamBold
btnESP.TextSize = 12
btnESP.Parent = parent2
local cE = Instance.new("UICorner"); cE.CornerRadius = UDim.new(0,8); cE.Parent = btnESP
local sE = Instance.new("UIStroke")
sE.Color = Color3.fromRGB(60,60,60); sE.Thickness = 1.1; sE.Parent = btnESP

local lblSpeed = Instance.new("TextLabel")
lblSpeed.Size = UDim2.new(0.85,0,0,15)
lblSpeed.Position = UDim2.new(0.075,0,0.14,0)
lblSpeed.BackgroundTransparency = 1
lblSpeed.Text = "CONTROLES DE VELOCIDAD"
lblSpeed.TextColor3 = Color3.fromRGB(0,200,255)
lblSpeed.Font = Enum.Font.GothamBold
lblSpeed.TextSize = 12
lblSpeed.TextXAlignment = Enum.TextXAlignment.Left
lblSpeed.Parent = parent2

local btnLoop = Instance.new("TextButton")
btnLoop.Size = UDim2.new(0.4,0,0,23)
btnLoop.Position = UDim2.new(0.075,0,0.19,0)
btnLoop.BackgroundColor3 = Color3.fromRGB(30,30,30)
btnLoop.Text = "Loop WS: OFF"
btnLoop.TextColor3 = Color3.fromRGB(255,255,255)
btnLoop.Font = Enum.Font.Gotham
btnLoop.TextSize = 11
btnLoop.Parent = parent2
local cL = Instance.new("UICorner"); cL.CornerRadius = UDim.new(0,5); cL.Parent = btnLoop

local tbWs = Instance.new("TextBox")
tbWs.Size = UDim2.new(0.4,0,0,23)
tbWs.Position = UDim2.new(0.525,0,0.19,0)
tbWs.BackgroundColor3 = Color3.fromRGB(40,40,40)
tbWs.TextColor3 = Color3.fromRGB(255,255,255)
tbWs.Font = Enum.Font.Gotham
tbWs.TextSize = 11
tbWs.Text = tostring(getgenv().Walkspeed)
tbWs.PlaceholderText = "WalkSpeed"
tbWs.Parent = parent2
local cW = Instance.new("UICorner"); cW.CornerRadius = UDim.new(0,5); cW.Parent = tbWs

local btnTp = Instance.new("TextButton")
btnTp.Size = UDim2.new(0.4,0,0,23)
btnTp.Position = UDim2.new(0.075,0,0.24,0)
btnTp.BackgroundColor3 = Color3.fromRGB(30,30,30)
btnTp.Text = "TP Walk: OFF (R)"
btnTp.TextColor3 = Color3.fromRGB(255,255,255)
btnTp.Font = Enum.Font.Gotham
btnTp.TextSize = 11
btnTp.Parent = parent2
local cT = Instance.new("UICorner"); cT.CornerRadius = UDim.new(0,5); cT.Parent = btnTp

local tbTp = Instance.new("TextBox")
tbTp.Size = UDim2.new(0.4,0,0,23)
tbTp.Position = UDim2.new(0.525,0,0.24,0)
tbTp.BackgroundColor3 = Color3.fromRGB(40,40,40)
tbTp.TextColor3 = Color3.fromRGB(255,255,255)
tbTp.Font = Enum.Font.Gotham
tbTp.TextSize = 11
tbTp.Text = tostring(getgenv().TPSpeed)
tbTp.PlaceholderText = "TP Speed (1-50)"
tbTp.Parent = parent2
local cT2 = Instance.new("UICorner"); cT2.CornerRadius = UDim.new(0,5); cT2.Parent = tbTp

local lblTpInfo = Instance.new("TextLabel")
lblTpInfo.Size = UDim2.new(0.85,0,0,15)
lblTpInfo.Position = UDim2.new(0.075,0,0.29,0)
lblTpInfo.BackgroundTransparency = 1
lblTpInfo.Text = "TP Speed: 1 = 1.5x | 50 = 150x"
lblTpInfo.TextColor3 = Color3.fromRGB(150,200,255)
lblTpInfo.Font = Enum.Font.Gotham
lblTpInfo.TextSize = 8
lblTpInfo.TextXAlignment = Enum.TextXAlignment.Left
lblTpInfo.TextWrapped = true
lblTpInfo.Parent = parent2

local lblFake = Instance.new("TextLabel")
lblFake.Size = UDim2.new(0.85,0,0,15)
lblFake.Position = UDim2.new(0.075,0,0.33,0)
lblFake.BackgroundTransparency = 1
lblFake.Text = "FAKE INVISIBILIDAD (3 MODOS)"
lblFake.TextColor3 = Color3.fromRGB(255,255,0)
lblFake.Font = Enum.Font.GothamBold
lblFake.TextSize = 12
lblFake.TextXAlignment = Enum.TextXAlignment.Left
lblFake.Parent = parent2

local btnFake = Instance.new("TextButton")
btnFake.Size = UDim2.new(0.4,0,0,23)
btnFake.Position = UDim2.new(0.075,0,0.37,0)
btnFake.BackgroundColor3 = Color3.fromRGB(30,30,30)
btnFake.Text = "Fake Invis: OFF"
btnFake.TextColor3 = Color3.fromRGB(255,80,80)
btnFake.Font = Enum.Font.GothamBold
btnFake.TextSize = 11
btnFake.Parent = parent2
local cF = Instance.new("UICorner"); cF.CornerRadius = UDim.new(0,5); cF.Parent = btnFake
local sF = Instance.new("UIStroke")
sF.Color = Color3.fromRGB(60,60,60); sF.Thickness = 1.1; sF.Parent = btnFake

local btnMode = Instance.new("TextButton")
btnMode.Size = UDim2.new(0.4,0,0,23)
btnMode.Position = UDim2.new(0.525,0,0.37,0)
btnMode.BackgroundColor3 = Color3.fromRGB(40,70,40)
btnMode.Text = "ESTÁTICO"
btnMode.TextColor3 = Color3.fromRGB(80,255,80)
btnMode.Font = Enum.Font.GothamBold
btnMode.TextSize = 11
btnMode.Parent = parent2
local cM = Instance.new("UICorner"); cM.CornerRadius = UDim.new(0,5); cM.Parent = btnMode

local lblMode = Instance.new("TextLabel")
lblMode.Size = UDim2.new(0.85,0,0,20)
lblMode.Position = UDim2.new(0.075,0,0.42,0)
lblMode.BackgroundTransparency = 1
lblMode.Text = "Modo: ESTÁTICO - INACTIVO"
lblMode.TextColor3 = Color3.fromRGB(150,255,150)
lblMode.Font = Enum.Font.Gotham
lblMode.TextSize = 8
lblMode.TextXAlignment = Enum.TextXAlignment.Left
lblMode.TextWrapped = true
lblMode.Parent = parent2

local lblKeys = Instance.new("TextLabel")
lblKeys.Size = UDim2.new(0.85,0,0,20)
lblKeys.Position = UDim2.new(0.075,0,0.48,0)
lblKeys.BackgroundTransparency = 1
lblKeys.Text = "Teclas: Q=ESP, R=TP, T=Fake, Z=Cambiar Modo"
lblKeys.TextColor3 = Color3.fromRGB(200,200,100)
lblKeys.Font = Enum.Font.GothamBold
lblKeys.TextSize = 8
lblKeys.TextXAlignment = Enum.TextXAlignment.Left
lblKeys.TextWrapped = true
lblKeys.Parent = parent2

-- Refresco de UI
local function refreshFakeUI()
    local mode = _G.GetFakeMode and _G.GetFakeMode() or "Estático"
    local on   = _G.IsFakeInvisEnabled and _G.IsFakeInvisEnabled() or false
    local desc = _G.GetModeDescription and _G.GetModeDescription() or ""

    if mode == "Estático" then
        btnMode.Text = "ESTÁTICO"
        btnMode.BackgroundColor3 = Color3.fromRGB(40,70,40)
        btnMode.TextColor3 = Color3.fromRGB(80,255,80)
        lblMode.Text = string.format("Modo: ESTÁTICO (%s) - %s", desc, on and "ACTIVO" or "INACTIVO")
    elseif mode == "Parpadeo" then
        btnMode.Text = "PARPADEO"
        btnMode.BackgroundColor3 = Color3.fromRGB(40,70,40)
        btnMode.TextColor3 = Color3.fromRGB(80,255,80)
        lblMode.Text = string.format("Modo: PARPADEO (%s) - %s", desc, on and "ACTIVO" or "INACTIVO")
    else
        btnMode.Text = "ANTI HS"
        btnMode.BackgroundColor3 = Color3.fromRGB(40,70,40)
        btnMode.TextColor3 = Color3.fromRGB(255,200,80)
        lblMode.Text = string.format("Modo: ANTI HS (%s) - %s", desc, on and "ACTIVO" or "INACTIVO")
    end

    if on then
        btnFake.Text = "Fake Invis: ON"
        btnFake.TextColor3 = Color3.fromRGB(80,255,80)
        btnFake.BackgroundColor3 = Color3.fromRGB(40,70,40)
        sF.Color = Color3.fromRGB(80,150,80)
    else
        btnFake.Text = "Fake Invis: OFF"
        btnFake.TextColor3 = Color3.fromRGB(255,80,80)
        btnFake.BackgroundColor3 = Color3.fromRGB(30,30,30)
        sF.Color = Color3.fromRGB(60,60,60)
    end
end

local function refreshQuickUI()
    if _G.IsFakeInvisEnabled and _G.IsFakeInvisEnabled() or false then
        btnInvis.BackgroundColor3 = Color3.fromRGB(40,70,40)
        btnInvis.TextColor3 = Color3.fromRGB(80,255,80)
    else
        btnInvis.BackgroundColor3 = Color3.fromRGB(30,30,30)
        btnInvis.TextColor3 = Color3.fromRGB(255,255,100)
    end

    if getgenv().TPWalk then
        btnTpw.BackgroundColor3 = Color3.fromRGB(40,70,40)
        btnTpw.TextColor3 = Color3.fromRGB(80,255,80)
    else
        btnTpw.BackgroundColor3 = Color3.fromRGB(30,30,30)
        btnTpw.TextColor3 = Color3.fromRGB(100,255,255)
    end

    if v2 then
        btnEsp.BackgroundColor3 = Color3.fromRGB(40,70,40)
        btnEsp.TextColor3 = Color3.fromRGB(80,255,80)
    else
        btnEsp.BackgroundColor3 = Color3.fromRGB(30,30,30)
        btnEsp.TextColor3 = Color3.fromRGB(255,80,80)
    end
end

local function refreshTpUI()
    if getgenv().TPWalk then
        btnTp.Text = "TP Walk: ON (R)"
        btnTp.BackgroundColor3 = Color3.fromRGB(0,150,0)
    else
        btnTp.Text = "TP Walk: OFF (R)"
        btnTp.BackgroundColor3 = Color3.fromRGB(30,30,30)
    end
    refreshQuickUI()
end

local function refreshLoopUI()
    if getgenv().loopW then
        btnLoop.Text = "Loop WS: ON"
        btnLoop.BackgroundColor3 = Color3.fromRGB(0,150,0)
    else
        btnLoop.Text = "Loop WS: OFF"
        btnLoop.BackgroundColor3 = Color3.fromRGB(30,30,30)
    end
end

local function toggleESP()
    f12()
    if v2 then
        btnESP.Text = "ESP: ON"
        btnESP.TextColor3 = Color3.fromRGB(80,255,80)
        btnESP.BackgroundColor3 = Color3.fromRGB(40,70,40)
        sE.Color = Color3.fromRGB(80,150,80)
    else
        btnESP.Text = "ESP: OFF"
        btnESP.TextColor3 = Color3.fromRGB(255,80,80)
        btnESP.BackgroundColor3 = Color3.fromRGB(30,30,30)
        sE.Color = Color3.fromRGB(60,60,60)
    end
    refreshQuickUI()
end

-- Conexiones
btnESP.MouseButton1Click:Connect(toggleESP)
btnLoop.MouseButton1Click:Connect(function()
    getgenv().loopW = not getgenv().loopW
    _G.loopW = getgenv().loopW
    refreshLoopUI()
end)
tbWs.FocusLost:Connect(function(enter)
    if enter then
        local n = tonumber(tbWs.Text)
        if n then
            getgenv().Walkspeed = n
            _G.Walkspeed = n
            tbWs.Text = tostring(n)
        end
    end
end)
tbTp.FocusLost:Connect(function(enter)
    if enter then
        local n = tonumber(tbTp.Text)
        if n then
            local v = math.clamp(n, 1, 50)
            getgenv().TPSpeed = v
            _G.TPSpeed = v
            tbTp.Text = tostring(v)
            lblTpInfo.Text = string.format("TP Speed: %d = %.1fx", v, f11(v))
        end
    end
end)
btnTp.MouseButton1Click:Connect(function()
    getgenv().TPWalk = not getgenv().TPWalk
    _G.TPWalk = getgenv().TPWalk
    refreshTpUI()
end)
btnFake.MouseButton1Click:Connect(function()
    if _G.ToggleFakeInvis then _G.ToggleFakeInvis(); refreshFakeUI(); refreshQuickUI() end
end)
btnMode.MouseButton1Click:Connect(function()
    if _G.ToggleFakeMode then _G.ToggleFakeMode(); refreshFakeUI(); refreshQuickUI() end
end)
btnInvis.MouseButton1Click:Connect(function()
    if _G.ToggleFakeInvis then _G.ToggleFakeInvis(); refreshFakeUI(); refreshQuickUI() end
end)
btnTpw.MouseButton1Click:Connect(function()
    getgenv().TPWalk = not getgenv().TPWalk
    _G.TPWalk = getgenv().TPWalk
    refreshTpUI(); refreshQuickUI()
end)
btnEsp.MouseButton1Click:Connect(toggleESP)

userInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.Q then
        toggleESP()
    elseif input.KeyCode == Enum.KeyCode.R then
        getgenv().TPWalk = not getgenv().TPWalk
        _G.TPWalk = getgenv().TPWalk
        refreshTpUI()
    elseif input.KeyCode == Enum.KeyCode.T then
        if _G.ToggleFakeInvis then _G.ToggleFakeInvis(); refreshFakeUI(); refreshQuickUI() end
    elseif input.KeyCode == Enum.KeyCode.Z then
        if _G.ToggleFakeMode then _G.ToggleFakeMode(); refreshFakeUI(); refreshQuickUI() end
    end
end)

localPlayer.CharacterAdded:Connect(function(c)
    humanoid = c:WaitForChild("Humanoid")
    if getgenv().loopW then humanoid.WalkSpeed = getgenv().Walkspeed end
    tbWs.Text = tostring(getgenv().Walkspeed)
    tbTp.Text = tostring(getgenv().TPSpeed)
    refreshLoopUI(); refreshTpUI()
    lblTpInfo.Text = string.format("TP Speed: %d = %.1fx", getgenv().TPSpeed, f11(getgenv().TPSpeed))
end)

players.PlayerAdded:Connect(function(p)
    if not f6(p) and v2 then f8(p) end
end)
players.PlayerRemoving:Connect(function(p)
    f10(p)
end)

-- Init
refreshLoopUI()
refreshTpUI()
refreshFakeUI()
refreshQuickUI()
lblTpInfo.Text = string.format("TP Speed: %d = %.1fx", getgenv().TPSpeed, f11(getgenv().TPSpeed))

print("=== DIOGO BR - SIN KILLAURA ===")
print("✅ Modos Fake Invis: ESTÁTICO | PARPADEO | ANTI HS")
print("✅ Teclas: Q=ESP, R=TP Walk, T=Fake Invis, Z=Modo")
workspace.FallenPartsDestroyHeight = 0/0
print("✅ Anti-caída activado.")