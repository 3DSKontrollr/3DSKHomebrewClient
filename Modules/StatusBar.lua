--- A status bar.
-- Displays battery left and current time
-- @module StatusBar
local StatusBar = {}

local ptm = require("ctr.ptm")
local gfx = require("ctr.gfx")
local theme = require("Modules/themes").current
local UI = require("Modules/UI")

--- Renders the status bar.
function StatusBar.Render()
    if not UI.isTopScreen then return end
    -- Battery
    theme.batteryBG:draw(370, 4)
    theme.batteryFill:drawPart(370,4,0,0, math.floor((ptm.getBatteryLevel()/5) * 24), 16)
    if ptm.getBatteryChargeState() then theme.batteryCharging:draw(370,4) end
    -- Hour
    gfx.text(6,2, os.date("%H:%M"))
end

return StatusBar