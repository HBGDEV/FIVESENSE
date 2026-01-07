--------------------------------------------------
-- FiveSense Helper
-- Animated Button ONLY
--------------------------------------------------

local helper = {}

helper._anim = {
    button = {}
}

--------------------------------------------------
-- Animated Button
--------------------------------------------------
function helper.AnimatedButton(id, label, w, h, r, g, b)
    local a = helper._anim.button[id] or 0.0
    local clicked = false

    if a > 0 then
        a = math.max(a - 0.08, 0)
    end

    local scale = 1.0 + a * 0.15
    local alpha = 0.6 + a * 0.4

    local cx, cy = ImGui.GetCursorPos()
    ImGui.SetCursorPos(
        cx + (w - w * scale) * 0.5,
        cy + (h - h * scale) * 0.5
    )

    ImGui.PushStyleColor(ImGuiCol.Button, r, g, b, alpha)
    ImGui.PushStyleColor(ImGuiCol.ButtonHovered, r, g, b, 1.0)
    ImGui.PushStyleColor(ImGuiCol.ButtonActive, r * 0.8, g * 0.8, b * 0.8, 1)

    if ImGui.Button(label, w * scale, h * scale) then
        a = 1.0
        clicked = true
    end

    ImGui.PopStyleColor(3)

    helper._anim.button[id] = a
    return clicked
end

return helper
