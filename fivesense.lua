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

    -- SELF
    selfGod = false,
    selfSpeed = 1.0,

    -- VEHICLE
    vehicleGod = false,
    vehicleSpeed = 1.0,

    -- WEAPON
    weaponExplosive = false,
    weaponDamage = 1.0,

    -- PLAYERS
    playersESP = false,
    playersRange = 250.0,

    -- WORLD
    worldTime = 12.0,
    worldGravity = 9.8,

    -- Animation
    animatingTab = nil,
    animationTime = 0,
    animationDuration = 1.5,

    -- welcome notification
    notified = false
}
menu.playerInfoOffset = { 518, 0 }


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
    "Self", "Vehicle", "Weapon", "Players", "World", "Settings" --- FOR THE FIVESENSE > TABNAME 
}



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
    "\u{f0c0}", "\u{f57d}", "\u{f013}" 
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
    ImGui.PushStyleVar(ImGuiStyleVar.FrameRounding, 4)
    ImGui.PushStyleVar(ImGuiStyleVar.ItemSpacing, 8, 6)
    ImGui.PushStyleVar(ImGuiStyleVar.WindowPadding, 10, 10)

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

    -- Combo / Dropdown
    ImGui.PushStyleColor(ImGuiCol.FrameBg, 0, 0, 0, 0)
    ImGui.PushStyleColor(ImGuiCol.FrameBgHovered, r, g, b, 0.25)
    ImGui.PushStyleColor(ImGuiCol.FrameBgActive, r, g, b, 0.35)

    -- Sliders / Checkboxes
    ImGui.PushStyleColor(ImGuiCol.CheckMark, r, g, b, 1)
    ImGui.PushStyleColor(ImGuiCol.SliderGrab, r, g, b, 1)
    ImGui.PushStyleColor(ImGuiCol.SliderGrabActive, r, g, b, 1)
end


local function PopFiveSenseStyle()
    ImGui.PopStyleColor(18)
    ImGui.PopStyleVar(5)
end

local function GetTabBreadcrumb()
    return "FiveSense > " .. (tabNames[menu.tab] or "Unknown")
end

--------------------------------------------------
-- UI FEATURES
--------------------------------------------------
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
    InfoRow("Vehicle:", inVeh and "Yes" or "No")

    ImGui.Columns(1)

    -- FLAGS
    ImGui.Spacing()
    ImGui.Separator()
    ImGui.Spacing()

    ImGui.TextDisabled("Flags")

    -- Smaller text for flags
    ImGui.SetWindowFontScale(0.85)

    local flags = {}

    if pid == myId then
        table.insert(flags, { "YOU", false })
    end

    local hostId = Natives.InvokeInt(0x8A8D0C4E3E6D2F8B)
    if pid == hostId then
        table.insert(flags, { "HOST", true })
    end

    local scriptHost = Natives.InvokeInt(0x1D6A14F1F9A736FC)
    if pid == scriptHost then
        table.insert(flags, { "SCRIPT HOST", true })
    end

    if health <= 0 then
        table.insert(flags, { "DEAD", false })
    end

    if inVeh then
        table.insert(flags, { "IN VEHICLE", false })
    end

    if dist < 50.0 then
        table.insert(flags, { "NEARBY", false })
    elseif dist > 500.0 then
        table.insert(flags, { "REMOTE", false })
    end

    if ped ~= 0 and Natives.InvokeBool(0x3882114BDE571AD4, ped) then
        table.insert(flags, { "INVINCIBLE", true })
    end

    if Natives.InvokeBool(0xE65F427EB70AB1ED, pid) then
        table.insert(flags, { "PASSIVE", false })
    end

    if Natives.InvokeBool(0x048746E388762E11, pid) then
        table.insert(flags, { "SPECTATING", true })
    end

    if ped == 0 then
        table.insert(flags, { "INVALID PED", true })
    end

    if #flags == 0 then
        ImGui.Text("None")
    else
        for _, flag in ipairs(flags) do
            local isRed = flag[2]
            if isRed then
                ImGui.TextColored(1.0, 0.2, 0.2, 1.0, "" .. flag[1])
            else
                ImGui.Text(flag[1])
            end
        end
    end

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
    
    
    if not menu.open then return end

    PushFiveSenseStyle()
    
    ImGui.SetNextWindowSize(515, 390)

    ImGui.Begin("##FiveSense", true,
        ImGuiWindowFlags.NoTitleBar |
        ImGuiWindowFlags.NoResize |
        ImGuiWindowFlags.NoScrollbar |
        ImGuiWindowFlags.NoScrollWithMouse
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
            if ImGui.Button(icon, -1, 42) then
    if menu.tab ~= i then
        menu.tab = i
        menu.animatingTab = i
        menu.animationTime = 0

        -- hide player info when leaving Players tab
        if i ~= 4 then
            menu.selectedPlayer = nil
            menu.showPlayerInfo = false
        end
    end
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

        local childW = (ImGui.GetContentRegionAvail() - 10) * 0.5
        local childH = 115
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
            ImGui.Text("THIS TAB IS AN EXAMPLE! ")
            ImGui.Spacing()
            ImGui.Text("CHECKBOX")
            menu.vehicleGod = ImGui.Checkbox("Godmode", menu.vehicleGod)
               ImGui.Spacing()
            ImGui.Text("BUTTON")
            ImGui.Button("Apply", 120, 24)
            ImGui.Spacing()
            ImGui.Text("SLIDER")
            menu.demoIntensity = ImGui.SliderFloat("Intensity", menu.demoIntensity, 0.0, 1.0)
            ImGui.Spacing()
            ImGui.Text("COMBO")
             if ImGui.BeginCombo("##theme", menu.theme) then
                for themeName, _ in pairs(themeData[menu.themeCategory]) do
                    if ImGui.Selectable(themeName, menu.theme == themeName) then
                        menu.theme = themeName
                    end
                end
                ImGui.EndCombo()
            end
        end

        --------------------------------------------------
        -- VEHICLE TAB
        --------------------------------------------------
        if menu.tab == 2 then
            ImGui.Text("EMPTY PLS FILL ")
        end
        --------------------------------------------------
        -- WEAPON TAB
        --------------------------------------------------
        if menu.tab == 3 then
               ImGui.Text("EMPTY PLS FILL ")
        end
        --------------------------------------------------
        -- PLAYER TAB
        --------------------------------------------------
    if menu.tab == 4 then
    ImGui.BeginChild("##player_icons", -1, -1, true)

    local myId = Natives.InvokeInt(0x4F8644AF03D0E0D6)

    for pid = 0, 31 do
        if Natives.InvokeBool(0xB8DFD30D6973E135, pid) then
            local name = Natives.InvokeString(0x6D0DE6A7B5DA71F8, pid) or "Unknown"
            local ped  = Natives.InvokeInt(0x43A66C31C68491C0, pid)
            local inVeh = ped ~= 0 and Natives.InvokeBool(0x997ABD671D25CA0B, ped)

            local r,g,b = 1,1,1
            if pid == myId then
                r,g,b = GetAccentColor()
            elseif inVeh then
                r,g,b = 0.3,0.8,1.0
            end

            ImGui.PushStyleColor(ImGuiCol.Button, 0.1,0.1,0.1,1)
            ImGui.PushStyleColor(ImGuiCol.ButtonHovered, r,g,b,0.9)
            ImGui.PushStyleColor(ImGuiCol.ButtonActive, r,g,b,1)

            if ImGui.Button("\u{f007}", 42, 42) then -- FontAwesome user icon
                menu.selectedPlayer = pid
            end

            ImGui.PopStyleColor(3)

            ImGui.SameLine()
            ImGui.Text(name)
            ImGui.Spacing()
        end
    end

    ImGui.EndChild()
    end
        --------------------------------------------------
        -- WORLD TAB
        --------------------------------------------------
        if menu.tab == 5 then
              ImGui.Text("EMPTY PLS FILL ")
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
            menu.demoIntensity = ImGui.SliderFloat("Intensity", menu.demoIntensity, 0.0, 1.0)
            ImGui.Button("Apply", 120, 24)
        end

        ImGui.EndChild()
    end

    ImGui.End()
    PopFiveSenseStyle()
    RenderPlayerInfoWindow()
end


--------------------------------------------------
-- REGISTER
--------------------------------------------------
LoadFontAwesome()

local handler = EventMgr.RegisterHandler(eLuaEvent.ON_PRESENT, RenderFiveSense)
EventMgr.RegisterHandler(eLuaEvent.ON_UNLOAD, function()
    EventMgr.RemoveHandler(handler)
end)