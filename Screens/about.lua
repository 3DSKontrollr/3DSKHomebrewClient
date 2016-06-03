--- About Screen
-- Credits and stuff
-- @module AboutScreen
local AboutScreen = {}

local gfx, ui = require("ctr.gfx"), require("Modules/UI")
local SM = require("Modules/ScreenManager")

-- Top Screen
function AboutScreen:RenderTopScreen()
    gfx.text(2,2, "3DSKontrollr+")
    gfx.text(2,18, "by>thebit.link")
end

-- Bottom Screen
function AboutScreen:RenderBottomScreen()
    if ui.Button(4,180,256,32,"< Go back") then
        SM:LoadScreen("test")
    end
end

return AboutScreen