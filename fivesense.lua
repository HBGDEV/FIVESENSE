--------------------------------------------------
-- FiveSense UI (Cherax ImGui)
--------------------------------------------------

-- MADE WITH ❤ BY BMX / SMELLYOU 
-- PLEASE LEAVE THIS HERE!
-- 

--------------------------------------------------
-- MENU STATE (MUST BE FIRST) - DO NOT CHANGE
--------------------------------------------------
local menu = {  -- MAIN MENU HELPERS
    open = false,
    tab = 1,

    theme = "RGB",
    selectedPlayer = nil,

    showPlayerInfo = false,

    demoCheckbox = false,
    demoIntensity = 0.5,


    -- Animation
    animatingTab = nil,
    animationTime = 0,
    animationDuration = 1.5,
    tabIndicatorAnim = 0,
    
    
  

    -- welcome notification
    notified = false,

    
    -- Notification system
    notifications = {},
    notificationIdCounter = 0,
    notificationPosition = "top_middle", -- top_left, top_middle, top_right
    

    -- Watermark
    showWatermark = true
}
menu.playerInfoOffset = { 610, 0 }
menu.scrollOffset = 0
menu.scrollTarget = 0
menu.scrollVelocity = 0


--------------------------------------------------
-- MENU FEATURES 
--------------------------------------------------

local function DRAW_TEXT(text)  -- credits to davidsuper2000 cherax discord
    -- BEGIN_TEXT_COMMAND_THEFEED_POST
    Natives.InvokeVoid(0x202709F4C58A0424, "STRING")

    -- ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME
    Natives.InvokeVoid(0x6C188BE134E074AA, text)

    -- END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT_WITH_CREW_TAG_AND_ADDITIONAL_ICON
    Natives.InvokeVoid(
        0x1CCD9A37359072CF,
        "CHAR_SOCIAL_CLUB",
        "CHAR_SOCIAL_CLUB",
        true,
        4,
        "Welcome to Fivesense",
        "v1.0",
        1.0,
        "",
        2,
        0
    )

    -- END_TEXT_COMMAND_THEFEED_POST_TICKER
    Natives.InvokeVoid(0x2ED7843F8F801023, false, false)
end
-----------------------------------------------
-- THEMES
--------------------------------------------------
local themeData = {
    Animated = {
        -- Existing (7)
        RGB = { mode = "rgb", speed = 2.0 },
        Neon = { mode = "gradient", colorA = { 0.0, 1.0, 0.6 }, colorB = { 0.0, 0.6, 1.0 }, speed = 1.5 },
        Sunset = { mode = "gradient", colorA = { 1.0, 0.35, 0.0 }, colorB = { 0.85, 0.0, 0.35 }, speed = 1.0 },
        Vaporwave = { mode = "gradient", colorA = { 0.9, 0.3, 1.0 }, colorB = { 0.3, 0.8, 1.0 }, speed = 0.8 },
        Toxic = { mode = "gradient", colorA = { 0.5, 1.0, 0.0 }, colorB = { 0.0, 0.4, 0.0 }, speed = 1.2 },
        Inferno = { mode = "gradient", colorA = { 1.0, 0.1, 0.0 }, colorB = { 0.2, 0.0, 0.0 }, speed = 1.0 },
        Pulse = { mode = "gradient", colorA = { 0.2, 0.2, 0.2 }, colorB = { 1.0, 1.0, 1.0 }, speed = 2.5 },

        -- Added (13)
        Ocean = { mode = "gradient", colorA = { 0.0, 0.4, 0.8 }, colorB = { 0.0, 0.8, 0.6 }, speed = 1.1 },
        Aurora = { mode = "gradient", colorA = { 0.2, 1.0, 0.7 }, colorB = { 0.4, 0.6, 1.0 }, speed = 0.9 },
        Plasma = { mode = "gradient", colorA = { 1.0, 0.0, 0.8 }, colorB = { 0.2, 0.0, 1.0 }, speed = 1.7 },
        IceFire = { mode = "gradient", colorA = { 0.0, 0.8, 1.0 }, colorB = { 1.0, 0.3, 0.0 }, speed = 1.4 },
        LimeWave = { mode = "gradient", colorA = { 0.6, 1.0, 0.2 }, colorB = { 0.2, 0.6, 0.1 }, speed = 1.6 },
        Galaxy = { mode = "gradient", colorA = { 0.15, 0.0, 0.3 }, colorB = { 0.6, 0.2, 0.8 }, speed = 0.7 },
        RoseShift = { mode = "gradient", colorA = { 1.0, 0.4, 0.6 }, colorB = { 0.8, 0.0, 0.3 }, speed = 1.3 },
        GoldRush = { mode = "gradient", colorA = { 1.0, 0.85, 0.2 }, colorB = { 1.0, 0.5, 0.0 }, speed = 1.0 },
        CyberBlue = { mode = "gradient", colorA = { 0.0, 0.9, 1.0 }, colorB = { 0.0, 0.3, 0.8 }, speed = 1.8 },
        Magma = { mode = "gradient", colorA = { 1.0, 0.2, 0.0 }, colorB = { 0.6, 0.0, 0.0 }, speed = 0.9 },
        MintGlow = { mode = "gradient", colorA = { 0.4, 1.0, 0.8 }, colorB = { 0.1, 0.6, 0.5 }, speed = 1.2 },
        Solar = { mode = "gradient", colorA = { 1.0, 0.9, 0.3 }, colorB = { 1.0, 0.4, 0.0 }, speed = 1.5 },
        VoidPulse = { mode = "gradient", colorA = { 0.05, 0.05, 0.05 }, colorB = { 0.6, 0.0, 0.9 }, speed = 2.0 }
    },

    Static = {
        -- Existing (7)
        Green = { mode = "static", color = { 0.0, 0.85, 0.0 } },
        Purple = { mode = "static", color = { 0.71, 0.24, 1.0 } },
        Red = { mode = "static", color = { 0.85, 0.15, 0.15 } },
        Cyan = { mode = "static", color = { 0.0, 0.85, 0.85 } },
        Amber = { mode = "static", color = { 1.0, 0.65, 0.0 } },
        White = { mode = "static", color = { 1.0, 1.0, 1.0 } },
        Pink = { mode = "static", color = { 1.0, 0.4, 0.7 } },

        -- Added (13)
        Blue = { mode = "static", color = { 0.0, 0.4, 0.9 } },
        Lime = { mode = "static", color = { 0.6, 1.0, 0.2 } },
        Orange = { mode = "static", color = { 1.0, 0.45, 0.0 } },
        Teal = { mode = "static", color = { 0.0, 0.6, 0.6 } },
        Magenta = { mode = "static", color = { 1.0, 0.0, 1.0 } },
        Navy = { mode = "static", color = { 0.05, 0.1, 0.3 } },
        Mint = { mode = "static", color = { 0.5, 1.0, 0.8 } },
        Lavender = { mode = "static", color = { 0.8, 0.6, 1.0 } },
        Gold = { mode = "static", color = { 1.0, 0.85, 0.3 } },
        Crimson = { mode = "static", color = { 0.6, 0.0, 0.1 } },
        Sky = { mode = "static", color = { 0.4, 0.7, 1.0 } },
        Charcoal = { mode = "static", color = { 0.15, 0.15, 0.15 } },
        Peach = { mode = "static", color = { 1.0, 0.7, 0.5 } }
    }
}




--------------------------------------------------
-- TABS
--------------------------------------------------
local tabNames = {
    "Self",
    "Vehicle",
    "Weapon",
    "Players",
    "Recovery",
    "Settings"
} --- FOR THE FIVESENSE > TABNAME 




--------------------------------------------------
-- FONT AWESOME
--------------------------------------------------
local function LoadFontAwesome()
    local path = FileMgr.GetMenuRootPath() .. "\\FontAwesome.ttf"
    if FileMgr.DoesFileExist(path) then
        ImGui.GetIO().Fonts:AddFontFromFileTTF(path, 24.0)
        menu.fontLoaded = true
    end
end

local tabIcons = { -- FONTAWSOME CHERAX HAS THEM BUILT IN 
    "\u{f007}", "\u{f1b9}", "\u{e19b}",
    "\u{f0c0}", "\u{f81d}", "\u{f013}" 
}
--------------------------------------------------
-- ACCENT COLOR
--------------------------------------------------
menu.themeCategory = "Static"
menu.theme = "Pink"
local function GetAccentColor() -- THE MATH FOR GETTING ACCENT COLOR
    local category = themeData[menu.themeCategory]
    local theme = category and category[menu.theme]
    
    if not theme then return 0.0, 0.85, 0.0 end

    if theme.mode == "rgb" then
        local t = os.clock() * theme.speed
        return
            math.sin(t) * 0.5 + 0.5,
            math.sin(t + 2.09) * 0.5 + 0.5,
            math.sin(t + 4.18) * 0.5 + 0.5
    end

    if theme.mode == "gradient" then
        local t = (math.sin(os.clock() * theme.speed) * 0.5 + 0.5)
        local a, b = theme.colorA, theme.colorB
        return
            a[1] + (b[1] - a[1]) * t,
            a[2] + (b[2] - a[2]) * t,
            a[3] + (b[3] - a[3]) * t
    end

    return theme.color[1], theme.color[2], theme.color[3]
end

--------------------------------------------------
-- ANIMATION PROGRESS
--------------------------------------------------


local function RenderAnimatedBreadcrumb()  -- TOP TEXT BAR 
    local r, g, b = GetAccentColor()

    -- Reset animation when tab changes
    if menu.lastTab ~= menu.tab then
        menu.breadcrumbAnim = 0.0
        menu.lastTab = menu.tab
    end

    -- Animate (clamped) - JUST TO STOP PROBLEMS
    menu.breadcrumbAnim = math.min(menu.breadcrumbAnim + 0.08, 1.0)

    -- Slide + fade
    local offsetX = (1.0 - menu.breadcrumbAnim) * -10
    local alpha   = menu.breadcrumbAnim

    ImGui.SetCursorPosX(ImGui.GetCursorPosX() + offsetX)
    ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, alpha)
    ImGui.Text("FiveSense > " .. (tabNames[menu.tab] or "Unknown"))
    ImGui.PopStyleColor()
end





--------------------------------------------------
-- STYLE
--------------------------------------------------
local function PushFiveSenseStyle()  -- Change how things look here
    local r, g, b = GetAccentColor()

    -- Style Vars
    ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 6)
    ImGui.PushStyleVar(ImGuiStyleVar.ChildRounding, 6)
    ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, 2)
    ImGui.PushStyleVar(ImGuiStyleVar.ItemSpacing, 8, 6)
    ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 10, 10)
    ImGui.PushStyleVar(ImGuiStyleVar.GrabMinSize, 12)
    ImGui.PushStyleVar(ImGuiStyleVar.GrabRounding, 2)

    -- Backgrounds
    ImGui.PushStyleColor(ImGuiCol.WindowBg, 0.05, 0.05, 0.05, 1)
    ImGui.PushStyleColor(ImGuiCol.ChildBg,  0.08, 0.08, 0.08, 1)
    ImGui.PushStyleColor(ImGuiCol.PopupBg,  0.07, 0.07, 0.07, 1)
    ImGui.PushStyleColor(ImGuiCol.Border,   0, 0, 0, 0)

    -- Text
    ImGui.PushStyleColor(ImGuiCol.Text, 0.92, 0.92, 0.92, 1)
    ImGui.PushStyleColor(ImGuiCol.TextDisabled, 0.55, 0.55, 0.55, 1)

    -- Buttons
    ImGui.PushStyleColor(ImGuiCol.Button, 0.10, 0.10, 0.10, 0)
    ImGui.PushStyleColor(ImGuiCol.ButtonHovered, r, g, b, 1)
    ImGui.PushStyleColor(ImGuiCol.ButtonActive, r * 0.8, g * 0.8, b * 0.8, 1)

    -- Headers / Selectables
    ImGui.PushStyleColor(ImGuiCol.Header, 0.10, 0.10, 0.10, 0.6)
    ImGui.PushStyleColor(ImGuiCol.HeaderHovered, r, g, b, 0.85)
    ImGui.PushStyleColor(ImGuiCol.HeaderActive, r, g, b, 1)

    -- Combo / Dropdown - Enhanced styling
    ImGui.PushStyleColor(ImGuiCol.FrameBg, 0.12, 0.12, 0.12, 1)
    ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, r * 0.3, g * 0.3, b * 0.3, 1)
    ImGui.PushStyleColor(ImGuiCol.FrameBgActive, r * 0.4, g * 0.4, b * 0.4, 1)
    
    -- Dropdown popup styling
    ImGui.PushStyleColor(ImGuiCol.PopupBg, 0.08, 0.08, 0.08, 0.98)

    -- Sliders / Checkboxes - Use theme colors
    ImGui.PushStyleColor(ImGuiCol.CheckMark, r, g, b, 1)
    ImGui.PushStyleColor(ImGuiCol.SliderGrab, r, g, b, 1)
    ImGui.PushStyleColor(ImGuiCol.SliderGrabActive, r, g, b, 1)
    
    -- Scrollbar (hidden but functional)
    ImGui.PushStyleColor(ImGuiCol.ScrollbarBg, 0, 0, 0, 0)
    ImGui.PushStyleColor(ImGuiCol.ScrollbarGrab, 0, 0, 0, 0)
    ImGui.PushStyleColor(ImGuiCol.ScrollbarGrabHovered, 0, 0, 0, 0)
    ImGui.PushStyleColor(ImGuiCol.ScrollbarGrabActive, 0, 0, 0, 0)
end


local function PopFiveSenseStyle()
    ImGui.PopStyleColor(23)
    ImGui.PopStyleVar(7)
end

local function GetTabBreadcrumb()
    return "FiveSense > " .. (tabNames[menu.tab] or "Unknown")
end
--------------------------------------------------
-- CHEAT FEATURES - HELPERS
--------------------------------------------------
Natives.InvokeVoid(
    0x67C540AA08E4A6F5, -- PLAY_SOUND_FRONTEND
    -1,
    "CHECKPOINT_NORMAL",
    "HUD_MINI_GAME_SOUNDSET",
    true
)

local function GetPlayerName(playerId)
    return Natives.InvokeString(
        0x6D0DE6A7B5DA71F8, -- GET_PLAYER_NAME
        playerId
    )
end

-- PLAYER_ID native
local function GetPlayerId()
    return Natives.InvokeInt(
        0x4F8644AF03D0E0D6 -- PLAYER_ID
    )
end

-- Show toast
--[[GUI.AddToast(
    "PLUTO V1.O",
    "Welcome " .. GetPlayerName(GetPlayerId()),
    10000,
    eToastPos.TopRight
)]]



local function is_bit_set(val, pos)
    local mask = 2 ^ pos
    return math.floor(val / mask) % 2 == 1
end

local function SetPackedBool(index, val_bool, mp_char)
    local packed_index = math.floor(index / 32)
    local bit_pos = index % 32
    local stat_name = mp_char .. "_PACKED_STAT_BOOL" .. packed_index
    local hash = Utils.Joaat(stat_name)
    
    local success, current = Stats.GetInt(hash)
    if not success then current = 0 end
    
    local mask = 2 ^ bit_pos
    
    if val_bool then
        if not is_bit_set(current, bit_pos) then
            current = current + mask
        end
    else
        if is_bit_set(current, bit_pos) then
            current = current - mask
        end
    end
    
    -- Simulate 32-bit signed wrap-around (optional but safer)
    current = math.floor(current) % 4294967296
    if current >= 2147483648 then current = current - 4294967296 end
    
    Stats.SetInt(hash, current)
end

-- Range setter for both MP chars
local function SetPackedBoolRange(startId, endId, value)
    for i = startId, endId do
        SetPackedBool(i, value, "MP0")
        SetPackedBool(i, value, "MP1")
    end
end

--------------------------------------------------
-- NOTIFICATION SYSTEM
--------------------------------------------------
local function AddNotification(title, description, duration)
    menu.notificationIdCounter = menu.notificationIdCounter + 1
    local notif = {
        id = menu.notificationIdCounter,
        title = title,
        description = description,
        progress = 0,
        duration = duration or 3.0,
        startTime = os.clock(),
        alpha = 0,
        offsetY = -50
    }
    table.insert(menu.notifications, notif)
end

local function UpdateNotifications()
    local currentTime = os.clock()
    local toRemove = {}
    
    for i, notif in ipairs(menu.notifications) do
        local elapsed = currentTime - notif.startTime
        notif.progress = math.min(elapsed / notif.duration, 1.0)
        
        -- Ease in/out animation for alpha
        if notif.progress < 0.1 then
            -- Ease in (first 10%)
            notif.alpha = (notif.progress / 0.1)
        elseif notif.progress > 0.9 then
            -- Ease out (last 10%)
            notif.alpha = 1.0 - ((notif.progress - 0.9) / 0.1)
        else
            notif.alpha = 1.0
        end
        
        -- Ease in/out animation for offsetY
        if notif.progress < 0.15 then
            -- Slide in from top
            local t = notif.progress / 0.15
            notif.offsetY = -50 + (50 * (1 - (1 - t) * (1 - t) * (1 - t)))
        else
            notif.offsetY = 0
        end
        
        -- Mark for removal if expired
        if notif.progress >= 1.0 then
            table.insert(toRemove, i)
        end
    end
    
    -- Remove expired notifications
    for i = #toRemove, 1, -1 do
        table.remove(menu.notifications, toRemove[i])
    end
end

local function RenderNotifications()
    UpdateNotifications()
    
    local r, g, b = GetAccentColor()
    local startY = 20
    local spacing = 5
    
    -- Reverse order so newest appears at top
    for i = #menu.notifications, 1, -1 do
        local notif = menu.notifications[i]
        local notifW = 300
        local notifH = 70
        
        -- Calculate X position based on selected position
        local notifX
        if menu.notificationPosition == "top_left" then
            notifX = 20
        elseif menu.notificationPosition == "top_right" then
            notifX = 1920 - notifW - 20
        else -- top_middle
            notifX = (1920 - notifW) / 2
        end
        
        -- Calculate Y position with proper spacing
        local index = #menu.notifications - i
        local notifY = startY + index * (notifH + spacing) + notif.offsetY
        
        ImGui.SetNextWindowPos(notifX, notifY)
        ImGui.SetNextWindowSize(notifW, notifH)
        
        ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 6)
        ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 12, 10)
        ImGui.PushStyleColor(ImGuiCol.WindowBg, 0.08, 0.08, 0.08, notif.alpha * 0.95)
        ImGui.PushStyleColor(ImGuiCol.Border, r, g, b, notif.alpha * 0.6)
        
        ImGui.Begin("##notification_" .. notif.id, true,
            ImGuiWindowFlags.NoTitleBar |
            ImGuiWindowFlags.NoResize |
            ImGuiWindowFlags.NoMove |
            ImGuiWindowFlags.NoScrollbar |
            ImGuiWindowFlags.NoCollapse
        )
        
        -- Title
        ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, notif.alpha)
        ImGui.Text(notif.title)
        ImGui.PopStyleColor()
        
        -- Description
        ImGui.SetWindowFontScale(0.85)
        ImGui.TextColored(0.7, 0.7, 0.7, notif.alpha, notif.description)
        ImGui.SetWindowFontScale(1.0)
        
        -- Progress bar
        ImGui.Spacing()
        ImGui.PushStyleColor(ImGuiCol.PlotHistogram, r, g, b, notif.alpha)
        ImGui.ProgressBar(notif.progress, -1, 3)
        ImGui.PopStyleColor()
        
        ImGui.End()
        ImGui.PopStyleColor(2)
        ImGui.PopStyleVar(2)
    end
end

--------------------------------------------------
-- UI FEATURES
--------------------------------------------------

local function RenderWatermark()
    if not menu.showWatermark then return end
    
    local r, g, b = GetAccentColor()
    
    -- Position in top-right corner
    local screenWidth, screenHeight = ImGui.GetDisplaySize()
    ImGui.SetNextWindowPos(screenWidth - 180, 10, ImGuiCond.Always)
    ImGui.SetNextWindowSize(170, 55, ImGuiCond.Always)
    
    ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 6)
    ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 8, 6)
    ImGui.PushStyleColor(ImGuiCol.WindowBg, 0.05, 0.05, 0.05, 0.9)
    ImGui.PushStyleColor(ImGuiCol.Border, r, g, b, 0.5)
    
    ImGui.Begin("##FiveSense_Watermark", true,
        ImGuiWindowFlags.NoTitleBar |
        ImGuiWindowFlags.NoResize |
        ImGuiWindowFlags.NoMove |
        ImGuiWindowFlags.NoScrollbar |
        ImGuiWindowFlags.NoCollapse
    )
    
    -- Title with accent color
    ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
    ImGui.SetWindowFontScale(1.0)
    ImGui.Text("FiveSense")
    ImGui.SetWindowFontScale(1.0)
    ImGui.PopStyleColor()
    
    -- Version and author
    ImGui.SetWindowFontScale(0.75)
    ImGui.TextDisabled("v1.0 by BMX")
    ImGui.SetWindowFontScale(1.0)
    
    ImGui.End()
    ImGui.PopStyleColor(2)
    ImGui.PopStyleVar(2)
end

local function RenderPlayerInfoWindow() --- the renderer and flag functions to render player flags 
    if not menu.selectedPlayer or not menu.open then 
        menu.playerInfoAnim = 0
        return 
    end

    local pid = menu.selectedPlayer
    if not Natives.InvokeBool(0xB8DFD30D6973E135, pid) then
        menu.selectedPlayer = nil
        menu.playerInfoAnim = 0
        return
    end

    -- Animate open
    menu.playerInfoAnim = menu.playerInfoAnim or 0
    menu.playerInfoAnim = math.min(menu.playerInfoAnim + 0.12, 1.0)

    local r, g, b = GetAccentColor()

    local px = menu.mainPosX + menu.playerInfoOffset[1] + (1.0 - menu.playerInfoAnim) * 80
    local py = menu.mainPosY + menu.playerInfoOffset[2]

    ImGui.SetNextWindowPos(px, py, ImGuiCond.Always)
    ImGui.SetNextWindowSize(250, 390, ImGuiCond.Always)

    ImGui.PushStyleVar(ImGuiStyleVar.WindowRounding, 6)
    ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 14, 12)

    ImGui.PushStyleColor(ImGuiCol.WindowBg, 0.05, 0.05, 0.05, menu.playerInfoAnim)
    ImGui.PushStyleColor(ImGuiCol.Border, 0, 0, 0, 0)

    ImGui.Begin("##FiveSense_PlayerInfo", true,
        ImGuiWindowFlags.NoTitleBar |
        ImGuiWindowFlags.NoResize |
        ImGuiWindowFlags.NoScrollbar
    )

    -- Header
    ImGui.PushStyleColor(ImGuiCol.Button, r, g, b, menu.playerInfoAnim)
    ImGui.Button("##header", -1, 3)
    ImGui.PopStyleColor()

    ImGui.Spacing()
    ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, menu.playerInfoAnim)
    ImGui.Text("PLAYER INFO")
    ImGui.PopStyleColor()
    ImGui.Separator()
    ImGui.Spacing()

    -- Player data
    local name = Natives.InvokeString(0x6D0DE6A7B5DA71F8, pid) or "Unknown"
    local ped = Natives.InvokeInt(0x43A66C31C68491C0, pid)

    local health = ped ~= 0 and Natives.InvokeInt(0xEEF059FAD016D209, ped) or 0
    local armor  = ped ~= 0 and Natives.InvokeInt(0x9483AF821605B1D8, ped) or 0
    local inVeh  = ped ~= 0 and Natives.InvokeBool(0x997ABD671D25CA0B, ped) or false

    local myId = Natives.InvokeInt(0x4F8644AF03D0E0D6)
    local myPed = Natives.InvokeInt(0x43A66C31C68491C0, myId)

    local dist = myPed ~= 0 and ped ~= 0 and
        Natives.InvokeFloat(0xF6F5161F4534EDFF, myPed, ped, true) or 0.0

    -- Info table
    ImGui.Columns(2)
    ImGui.SetColumnWidth(0, 90)

    local function InfoRow(label, value)
        ImGui.TextDisabled(label)
        ImGui.NextColumn()
        ImGui.Text(tostring(value))
        ImGui.NextColumn()
    end

    InfoRow("Name:", name)
    InfoRow("Player ID:", pid)
    InfoRow("Health:", health)
    InfoRow("Armor:", armor)
    InfoRow("Distance:", string.format("%.1f m", dist))

    ImGui.Columns(1)

    -- FLAGS
    ImGui.Spacing()
    ImGui.Separator(ImGuiCond.NoResize)
    ImGui.Spacing()

    ImGui.TextDisabled("Flags")

    -- Smaller text for flags
    ImGui.SetWindowFontScale(0.65)

    -- Define all possible flags with their check functions
    local allFlags = {
        { name = "YOU", check = function() return pid == myId end },
        { name = "SCRIPT HOST", check = function() return pid == Natives.InvokeInt(0x1D6A14F1F9A736FC) end },
        { name = "PLAYING", check = function() return Natives.InvokeBool(0x57D158647A6BFABF, pid) end },
        { name = "ACTIVE", check = function() return Natives.InvokeBool(0xB8DFD30D6973E135, pid) end },
        { name = "CONNECTED", check = function() return Natives.InvokeBool(0x93DC1BE4E1ABE9D1, pid) end },
        { name = "DEAD", check = function() return health <= 0 end },
        { name = "SHOOTING", check = function() return ped ~= 0 and Natives.InvokeBool(0xD6A86331A537A7B9, ped) end },
        { name = "AIMING", check = function() return ped ~= 0 and Natives.InvokeBool(0x2E397FD2ECD37C87, ped) end },
        { name = "IN VEH", check = function() return inVeh end },
        { name = "DRIVING", check = function() return ped ~= 0 and Natives.InvokeBool(0x997ABD671D25CA0B, ped) and Natives.InvokeBool(0x5F696E4F4C3E7E3E, ped) end },
        { name = "PARACHUTE", check = function() return ped ~= 0 and Natives.InvokeBool(0x7DCE8BDA0F1C1200, ped) end },
        { name = "SWIMMING", check = function() return ped ~= 0 and Natives.InvokeBool(0x9DE327631295B4C2, ped) end },
        { name = "CLIMBING", check = function() return ped ~= 0 and Natives.InvokeBool(0x53E8CB4F48BFE623, ped) end },
        { name = "JUMPING", check = function() return ped ~= 0 and Natives.InvokeBool(0xCEDABC5900A0BF97, ped) end },
        { name = "FALLING", check = function() return ped ~= 0 and Natives.InvokeBool(0xFB92A102F1C4DFA3, ped) end },
        { name = "RUNNING", check = function() return ped ~= 0 and Natives.InvokeBool(0xC5286FFC176F28A2, ped) end },
        { name = "SPRINTING", check = function() return ped ~= 0 and Natives.InvokeBool(0x57E457CD2C0FC168, ped) end },
        { name = "RAGDOLL", check = function() return ped ~= 0 and Natives.InvokeBool(0x47E4E977581C5B55, ped) end },
        { name = "ON FOOT", check = function() return ped ~= 0 and Natives.InvokeBool(0x01FEE67DB37F59B2, ped) end },
        { name = "RELOADING", check = function() return ped ~= 0 and Natives.InvokeBool(0x24B100C68C645951, ped) end },
        { name = "IN COVER", check = function() return ped ~= 0 and Natives.InvokeBool(0x60DFD0691A170B88, ped) end },
    }

    -- Display flags in 2 columns to fit horizontally
    ImGui.Columns(2, "##flags", false)
    ImGui.SetColumnWidth(0, 110)
    
    for i, flagData in ipairs(allFlags) do
        local isActive = false
        pcall(function()
            isActive = flagData.check()
        end)
        
        if isActive then
            -- Active flag - show in red
            ImGui.TextColored(1.0, 0.2, 0.2, 1.0, flagData.name)
        else
            -- Inactive flag - show greyed out
            ImGui.TextDisabled(flagData.name)
        end
        
        ImGui.NextColumn()
    end
    
    ImGui.Columns(1)
    ImGui.SetWindowFontScale(1.0)

    ImGui.End()

    ImGui.PopStyleColor(2)
    ImGui.PopStyleVar(2)
end


--------------------------------------------------
-- MAIN RENDER
--------------------------------------------------

DRAW_TEXT("Press INS To Open!")  --- display welcome text before rendering ui 
local function RenderFiveSense()
   --RenderCrosshairWindow() // func needs fixed since i couldnt figure out how to get a mouse curson /// thanks to chat gpt for the

    if ImGui.IsKeyPressed(ImGuiKey.Insert) then
    menu.open = not menu.open

    if menu.open and not menu.notified then
        menu.notified = true
    end
    end
    
    -- Render watermark always (even when menu is closed)
    RenderWatermark()
    
    if not menu.open then return end

    PushFiveSenseStyle()
    
    ImGui.SetNextWindowSize(600, 500)

    ImGui.Begin("##FiveSense", true,
        ImGuiWindowFlags.NoTitleBar |
        ImGuiWindowFlags.NoResize
    )
    menu.mainPosX, menu.mainPosY = ImGui.GetWindowPos()
    menu.mainSizeX, menu.mainSizeY = ImGui.GetWindowSize()

    local r, g, b = GetAccentColor()

    ImGui.PushStyleColor(ImGuiCol.Button, r, g, b, 1)
    ImGui.Button("##topbar", -1, 3)
    ImGui.PopStyleColor()

    ImGui.Spacing()

    if ImGui.BeginChild("##sidebar", 120, -1, true) then
        for i, icon in ipairs(tabIcons) do
            local buttonPosY = ImGui.GetCursorPosY()
            
            if ImGui.Button(icon, -1, 42) then
    if menu.tab ~= i then
        menu.tab = i
        menu.animatingTab = i
        menu.animationTime = 0
        menu.tabIndicatorAnim = 0  -- Reset animation

        -- hide player info when leaving Players tab
        if i ~= 4 then
            menu.selectedPlayer = nil
            menu.showPlayerInfo = false
        end
    end
        end
            
            -- Draw animated indicator bar under selected tab
            if menu.tab == i then
                -- Animate the indicator (expand from center)
                menu.tabIndicatorAnim = math.min(menu.tabIndicatorAnim + 0.03, 1.0)
                
                local barWidth = 100 * menu.tabIndicatorAnim
                local barHeight = 3
                local barX = (120 - barWidth) * 0.5  -- Center the bar
                local barY = buttonPosY + 42 + 2  -- Just below button
                
                local r, g, b = GetAccentColor()
                
                ImGui.SetCursorPos(barX, barY)
                ImGui.PushStyleColor(ImGuiCol.Button, r, g, b, 1)
                ImGui.Button("##indicator" .. i, barWidth, barHeight)
                ImGui.PopStyleColor()
            end
            
            ImGui.Spacing()
        end
        ImGui.EndChild()
    end

    ImGui.SameLine()

    if ImGui.BeginChild("##content", -1, -1, true) then
        RenderAnimatedBreadcrumb()
        ImGui.Separator()
        ImGui.Spacing()

        local availWidth = ImGui.GetContentRegionAvail()
        local childW = (availWidth - 10) * 0.5
        local childH = 200
        local btnH   = 22

        local function CenterTitle(text)
            local w = ImGui.CalcTextSize(text)
            ImGui.SetCursorPosX((ImGui.GetWindowWidth() - w) * 0.5)
            ImGui.Text(text)
            ImGui.PushStyleColor(ImGuiCol.Separator, r, g, b, 0.9)
            ImGui.Separator()
            ImGui.PopStyleColor()
            ImGui.Spacing()
        end
        
        --------------------------------------------------
        -- SELF TAB
        --------------------------------------------------
        if menu.tab == 1 then
            -- Top Row
            -- Quick Actions (Top Left)
            if ImGui.BeginChild("##self_buttons", childW, childH, true) then
                ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
                ImGui.Text("QUICK ACTIONS")
                ImGui.PopStyleColor()
                ImGui.Separator()
                ImGui.Spacing()
                
                ImGui.TextDisabled("Placeholder for quick action buttons")
                ImGui.TextDisabled("Feature functionality removed")
                ImGui.TextDisabled("UI template only")
                
                ImGui.EndChild()
            end
            
            ImGui.SameLine()
            
            -- Toggles (Top Right)
            if ImGui.BeginChild("##self_checkboxes", childW, childH, true) then
                ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
                ImGui.Text("TOGGLES")
                ImGui.PopStyleColor()
                ImGui.Separator()
                ImGui.Spacing()
                
                ImGui.TextDisabled("Placeholder for toggle checkboxes")
                ImGui.TextDisabled("Feature functionality removed")
                ImGui.TextDisabled("UI template only")
                
                ImGui.EndChild()
            end
            
            -- Bottom Row
            -- Movement Speed (Bottom Left)
            if ImGui.BeginChild("##self_sliders", childW, childH, true) then
                ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
                ImGui.Text("SLIDERS")
                ImGui.PopStyleColor()
                ImGui.Separator()
                ImGui.Spacing()
                
                ImGui.TextDisabled("Placeholder for slider controls")
                ImGui.TextDisabled("Feature functionality removed")
                ImGui.TextDisabled("UI template only")
                
                ImGui.EndChild()
            end
            
            ImGui.SameLine()
            
            -- Options (Bottom Right)
            if ImGui.BeginChild("##self_dropdowns", childW, childH, true) then
                ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
                ImGui.Text("DROPDOWNS")
                ImGui.PopStyleColor()
                ImGui.Separator()
                ImGui.Spacing()
                
                ImGui.TextDisabled("Placeholder for dropdown menus")
                ImGui.TextDisabled("Feature functionality removed")
                ImGui.TextDisabled("UI template only")
                
                ImGui.EndChild()
            end
        end
        
        --------------------------------------------------
        -- VEHICLE TAB
        --------------------------------------------------
        if menu.tab == 2 then
            -- Top Row
            -- Vehicle Actions (Top Left)
            if ImGui.BeginChild("##vehicle_buttons", childW, childH, true) then
                ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
                ImGui.Text("BUTTONS")
                ImGui.PopStyleColor()
                ImGui.Separator()
                ImGui.Spacing()
                
                ImGui.TextDisabled("Placeholder for vehicle action buttons")
                ImGui.TextDisabled("Feature functionality removed")
                ImGui.TextDisabled("UI template only")
                
                ImGui.EndChild()
            end
            
            ImGui.SameLine()
            
            -- Vehicle Toggles (Top Right)
            if ImGui.BeginChild("##vehicle_checkboxes", childW, childH, true) then
                ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
                ImGui.Text("TOGGLES")
                ImGui.PopStyleColor()
                ImGui.Separator()
                ImGui.Spacing()
                
                ImGui.TextDisabled("Placeholder for vehicle toggles")
                ImGui.TextDisabled("Feature functionality removed")
                ImGui.TextDisabled("UI template only")
                
                ImGui.EndChild()
            end
            
            -- Bottom Row
            -- Speed Settings (Bottom Left)
            if ImGui.BeginChild("##vehicle_sliders", childW, childH, true) then
                ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
                ImGui.Text("SLIDERS")
                ImGui.PopStyleColor()
                ImGui.Separator()
                ImGui.Spacing()
                
                ImGui.TextDisabled("Placeholder for vehicle sliders")
                ImGui.TextDisabled("Feature functionality removed")
                ImGui.TextDisabled("UI template only")
                
                ImGui.EndChild()
            end
            
            ImGui.SameLine()
            
            -- Vehicle Options (Bottom Right)
            if ImGui.BeginChild("##vehicle_dropdowns", childW, childH, true) then
                ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
                ImGui.Text("DROPDOWNS")
                ImGui.PopStyleColor()
                ImGui.Separator()
                ImGui.Spacing()
                
                ImGui.TextDisabled("Placeholder for vehicle dropdowns")
                ImGui.TextDisabled("Feature functionality removed")
                ImGui.TextDisabled("UI template only")
                
                ImGui.EndChild()
            end
        end
        
        --------------------------------------------------
        -- WEAPON TAB
        --------------------------------------------------
        if menu.tab == 3 then
            -- Top Row
            if ImGui.BeginChild("##weapon_buttons", childW, childH, true) then
                ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
                ImGui.Text("BUTTONS")
                ImGui.PopStyleColor()
                ImGui.Separator()
                ImGui.Spacing()
                ImGui.TextDisabled("Placeholder for weapon buttons")
                ImGui.TextDisabled("Feature functionality removed")
                ImGui.TextDisabled("UI template only")
                ImGui.EndChild()
            end
            ImGui.SameLine()
            if ImGui.BeginChild("##weapon_checkboxes", childW, childH, true) then
                ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
                ImGui.Text("TOGGLES")
                ImGui.PopStyleColor()
                ImGui.Separator()
                ImGui.Spacing()
                ImGui.TextDisabled("Placeholder for weapon toggles")
                ImGui.TextDisabled("Feature functionality removed")
                ImGui.TextDisabled("UI template only")
                ImGui.EndChild()
            end
            if ImGui.BeginChild("##weapon_sliders", childW, childH, true) then
                ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
                ImGui.Text("SLIDERS")
                ImGui.PopStyleColor()
                ImGui.Separator()
                ImGui.Spacing()
                ImGui.TextDisabled("Placeholder for weapon sliders")
                ImGui.TextDisabled("Feature functionality removed")
                ImGui.TextDisabled("UI template only")
                ImGui.EndChild()
            end
            ImGui.SameLine()
            if ImGui.BeginChild("##weapon_dropdowns", childW, childH, true) then
                ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
                ImGui.Text("DROPDOWNS")
                ImGui.PopStyleColor()
                ImGui.Separator()
                ImGui.Spacing()
                ImGui.TextDisabled("Placeholder for weapon dropdowns")
                ImGui.TextDisabled("Feature functionality removed")
                ImGui.TextDisabled("UI template only")
                ImGui.EndChild()
            end
        end
        
        --------------------------------------------------
        -- PLAYER TAB
        --------------------------------------------------
        if menu.tab == 4 then
            ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
            ImGui.Text("PLAYER LIST")
            ImGui.PopStyleColor()
            ImGui.Separator()
            ImGui.Spacing()
            
            -- Player list - iterate through all possible player slots
            local playerCount = 0
            for i = 0, 31 do
                -- Check if player exists using NETWORK_IS_PLAYER_ACTIVE
                local isActive = Natives.InvokeBool(0xB8DFD30D6973E135, i)
                if isActive then
                    playerCount = playerCount + 1
                    local name = Natives.InvokeString(0x6D0DE6A7B5DA71F8, i) or "Unknown"
                    local isSelected = (menu.selectedPlayer == i)
                    
                    if ImGui.Selectable(string.format("[%d] %s", i, name), isSelected) then
                        menu.selectedPlayer = i
                        menu.showPlayerInfo = true
                    end
                end
            end
            
            -- Show message if no players found
            if playerCount == 0 then
                ImGui.TextDisabled("No players found in session")
                ImGui.TextDisabled("(You may be in single-player)")
            end
        end
        
        --------------------------------------------------
        -- RECOVERY TAB
        --------------------------------------------------
        if menu.tab == 5 then
            -- Top Row
            if ImGui.BeginChild("##recovery_buttons", childW, childH, true) then
                ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
                ImGui.Text("BUTTONS")
                ImGui.PopStyleColor()
                ImGui.Separator()
                ImGui.Spacing()
                ImGui.TextDisabled("Placeholder for recovery buttons")
                ImGui.TextDisabled("Feature functionality removed")
                ImGui.TextDisabled("UI template only")
                ImGui.EndChild()
            end
            ImGui.SameLine()
            if ImGui.BeginChild("##recovery_checkboxes", childW, childH, true) then
                ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
                ImGui.Text("TOGGLES")
                ImGui.PopStyleColor()
                ImGui.Separator()
                ImGui.Spacing()
                ImGui.TextDisabled("Placeholder for recovery toggles")
                ImGui.TextDisabled("Feature functionality removed")
                ImGui.TextDisabled("UI template only")
                ImGui.EndChild()
            end
            if ImGui.BeginChild("##recovery_sliders", childW, childH, true) then
                ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
                ImGui.Text("SLIDERS")
                ImGui.PopStyleColor()
                ImGui.Separator()
                ImGui.Spacing()
                ImGui.TextDisabled("Placeholder for recovery sliders")
                ImGui.TextDisabled("Feature functionality removed")
                ImGui.TextDisabled("UI template only")
                ImGui.EndChild()
            end
            ImGui.SameLine()
            if ImGui.BeginChild("##recovery_dropdowns", childW, childH, true) then
                ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
                ImGui.Text("DROPDOWNS")
                ImGui.PopStyleColor()
                ImGui.Separator()
                ImGui.Spacing()
                ImGui.TextDisabled("Placeholder for recovery dropdowns")
                ImGui.TextDisabled("Feature functionality removed")
                ImGui.TextDisabled("UI template only")
                ImGui.EndChild()
            end
        end
        
        --------------------------------------------------
        -- SETTINGS TAB (UNCHANGED FUNCTIONALLY)
        --------------------------------------------------
        if menu.tab == 6 then
            ImGui.Text("Theme Category")
            if ImGui.BeginCombo("##category", menu.themeCategory) then
                for catName, _ in pairs(themeData) do
                    if ImGui.Selectable(catName, menu.themeCategory == catName) then
                        menu.themeCategory = catName
                        menu.theme = next(themeData[catName])
                    end
                end
                ImGui.EndCombo()
            end

            ImGui.Spacing()
            ImGui.Text("Selected Theme")
            if ImGui.BeginCombo("##theme", menu.theme) then
                for themeName, _ in pairs(themeData[menu.themeCategory]) do
                    if ImGui.Selectable(themeName, menu.theme == themeName) then
                        menu.theme = themeName
                    end
                end
                ImGui.EndCombo()
            end

            ImGui.Separator()
            ImGui.Spacing()
            menu.demoCheckbox = ImGui.Checkbox("Enable Feature", menu.demoCheckbox)
            menu.demoIntensity = ImGui.SliderFloat("##intensity", menu.demoIntensity, 0.0, 1.0, "%.3f")
            ImGui.Button("Apply", 120, 24)
            
            ImGui.Separator()
            ImGui.Spacing()
            
            ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
            ImGui.Text("NOTIFICATION SETTINGS")
            ImGui.PopStyleColor()
            ImGui.Separator()
            ImGui.Spacing()
            
            ImGui.Text("Notification Position")
            ImGui.SetWindowFontScale(0.85)
            
            if ImGui.Checkbox("Top Left", menu.notificationPosition == "top_left") then
                menu.notificationPosition = "top_left"
            end
            
            if ImGui.Checkbox("Top Middle", menu.notificationPosition == "top_middle") then
                menu.notificationPosition = "top_middle"
            end
            
            if ImGui.Checkbox("Top Right", menu.notificationPosition == "top_right") then
                menu.notificationPosition = "top_right"
            end
            
            ImGui.SetWindowFontScale(1.0)
            
            ImGui.Spacing()
            if ImGui.Button("Test Notification", -1, 22) then
                AddNotification("Test", "This is a test notification", 3.0)
            end
            
            ImGui.Separator()
            ImGui.Spacing()
            
            ImGui.PushStyleColor(ImGuiCol.Text, r, g, b, 1)
            ImGui.Text("WATERMARK")
            ImGui.PopStyleColor()
            ImGui.Separator()
            ImGui.Spacing()
            
            menu.showWatermark = ImGui.Checkbox("Show Watermark", menu.showWatermark)
            ImGui.SetWindowFontScale(0.85)
            ImGui.TextDisabled("Display FiveSense watermark in top-right corner")
            ImGui.SetWindowFontScale(1.0)
        end

        ImGui.EndChild()
    end

    ImGui.End()
    PopFiveSenseStyle()
    RenderPlayerInfoWindow()
    RenderNotifications()
end


--------------------------------------------------
-- REGISTER
LoadFontAwesome()

local handler = EventMgr.RegisterHandler(eLuaEvent.ON_PRESENT, RenderFiveSense)
EventMgr.RegisterHandler(eLuaEvent.ON_UNLOAD, function()
    EventMgr.RemoveHandler(handler)
end)


