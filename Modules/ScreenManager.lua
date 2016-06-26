--- Screen Manager.
-- The App is separated on a per-screen basis, this module preloads all files in the Screens directory,
-- and keeps track of the current screen, so the correct one is rendered when requested.
-- @module ScreenManager
local ScreenManager = {}

local gfx = require("ctr.gfx")
local fs = require("ctr.fs")
local UI = require("Modules/UI")

ScreenManager.ScreenCache = {}
ScreenManager.CurrentScreen = ""
ScreenManager.ScreenToLoad = ""

--- Initialization
-- Preloads all files in the Screens directory
function ScreenManager:Init()
    local screenFiles = fs.list("Screens")
    for key,file in pairs(screenFiles) do
        if string.sub(file.name, -4) == ".lua" then
            local screenName = string.sub(file.name, 0, -5)
            local thisScreen = require("Screens/"..screenName)
            if thisScreen.Init ~= nil then thisScreen:Init() end
            self.ScreenCache[screenName] = thisScreen
        end
    end
end

--- Load Screen
-- Switches the current active screen
-- @string screenName Screen to load
function ScreenManager:LoadScreen(screenName)
    -- Execute the Unload function on the current screen.
    local screen = self.ScreenCache[self.CurrentScreen] or {}
    if screen.Unload ~= nil then screen:Unload() end
    -- Change the screen
    self.ScreenToLoad = screenName
    -- This might be the initial load
    if self.CurrentScreen == "" then self.CurrentScreen = screenName end
    -- Execute the Load function on the new screen
    local screen = self.ScreenCache[screenName] or self.ScreenCache[self.CurrentScreen]
    if screen.Load ~= nil then screen:Load() end
end

--- Render Screen
-- Renders the specified screen, or the current active screen
-- @string[opt] screenName Screen to render
function ScreenManager:Render(screenName)
    local screen = self.ScreenCache[screenName] or self.ScreenCache[self.CurrentScreen]
    -- Pre Render
    if screen.PreRender ~= nil then screen:PreRender() end
    -- Top Screen
    gfx.start(gfx.TOP)
        if not debug.consoleState then
            UI.isTopScreen = true
            if screen.RenderTopScreen ~= nil then screen:RenderTopScreen() end
            debug.Render()
            UI.isTopScreen = false
        end
    gfx.stop()
    -- Bottom Screen
    gfx.start(gfx.BOTTOM)
        if screen.RenderBottomScreen ~= nil then screen:RenderBottomScreen() end
    gfx.stop()
    -- Post Render
    if screen.PostRender ~= nil then screen:PostRender() end
    -- UISystem Update
    UI:Update()
    -- Actual Render
    gfx.render()
    -- Debug Update
    debug.Update()
    -- Load pending screen AFTER Render and PostRender to avoid graphic bugs
    self.CurrentScreen = self.ScreenToLoad
end

return ScreenManager
