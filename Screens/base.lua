--- Base screen file.
-- Use it as a boilerplate for new screens
-- @module BaseScreen
local BaseScreen = {}

local gfx = require("ctr.gfx")
local hid = require("ctr.hid")
local ui = require("Modules/UI")
local SM = require("Modules/ScreenManager")

--- Init function.
-- This always runs when the app is launched
function BaseScreen:Init()
    
end

--- Load function.
-- This function gets executed when entering the screen
function BaseScreen:Load()
    
end

--- Unload function.
-- This function gets executed before leaving the screen
function BaseScreen:Unload()
    
end

--- Render Top Screen.
-- Called once per frame (only if this is the current screen)
-- All gfx calls made here should render on the top screen
function BaseScreen:RenderTopScreen()
    
end

--- Render Bottom Screen.
-- Called once per frame (only if this is the current screen)
-- All gfx calls made here should render on the top screen
function BaseScreen:RenderBottomScreen()
    
end

--- Pre Render function
-- Called once per frame before rendering is done
function BaseScreen:PreRender()
  
end

--- Post Render function
-- Called once per frame after rendering is done
function BaseScreen:PostRender()
    
end

return BaseScreen