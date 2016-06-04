--- The Connection Screen.
-- The first screen shown after splash. 
-- @module ConnectionScreen
local ConnectionScreen = {}

local gfx = require("ctr.gfx")
local hid = require("ctr.hid")
local ui = require("Modules/UI")
local SM = require("Modules/ScreenManager")
local SB = require("Modules/StatusBar")
local theme = require("Modules/themes").current
local srv = require("Core/InternalServer")

--- Load function.
-- This function gets executed when entering the screen
function ConnectionScreen:Load()
    srv:Init()
end

--- Unload function.
-- This function gets executed before leaving the screen
function ConnectionScreen:Unload()
    
end

function ConnectionScreen:RenderTopScreen()
    theme.topScreenBG:draw(0,0)
    SB.Render()
end

function ConnectionScreen:RenderBottomScreen()
    theme.bottomScreenBG:draw(0,0)
    --srv:WaitForConnection()
    if ui.Button(4,180,256,32,"< Back") then
        SM:LoadScreen("test")
    end
end

return ConnectionScreen