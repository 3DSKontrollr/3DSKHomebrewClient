--- Debug Stuff for, uh, debugging.
-- @module DebugStuff
local DebugStuff = {}

local gfx = require("ctr.gfx")

DebugStuff.enabled = true
DebugStuff.allowLogToggle = true
DebugStuff.saveLogs = true
DebugStuff.logFile = "kontrollr.log"
DebugStuff.logAppend = false
DebugStuff.showFPS = true
DebugStuff.allowConsoleToggle = true
DebugStuff.consoleState = false

local _f = nil

--- Initializes the Debug Library
function DebugStuff.Init()
    if not DebugStuff.enabled then return end
    if DebugStuff.saveLogs and not DebugStuff.logAppend then
        -- Clear the logfile
        _f = io.open(DebugStuff.logFile, "w")
    else
        _f = io.open(DebugStuff.logFile, "a")
    end
end

--- Log.
-- Logs something to the logfile and console
function DebugStuff.Log (...)
    DebugStuff.Write("["..os.date("%H:%M:%S").."] ".. ...)
end

--- Write.
-- Writes something directly to the logfile (and console if enabled)
function DebugStuff.Write (...)
    if not DebugStuff.enabled then return end
    -- Print to console
    if DebugStuff.consoleState then
        print(...)
    end
    -- Write to logfile
    if DebugStuff.saveLogs then
        _f:write(..., "\n")
    end
end

--- Render.
-- Used by ScreenManager, called during render of the Top Screen
function DebugStuff.Render()
    if not DebugStuff.enabled then return end
    -- Obligatory [DEBUG MODE] watermark ;)
    local wm_color = gfx.color.hex(0xFF0000FF) -- Red By default
    if DebugStuff.saveLogs then wm_color = gfx.color.hex(0xFFFF00FF) end -- Yellow when logs are enabled
    gfx.text(310, 220 , "DEBUG MODE", nil, wm_color)

    -- FPS Counter (if enabled)
    if DebugStuff.showFPS then
        gfx.text(2, 220 , "FPS"..gfx.getFPS(), nil, gfx.color.hex(0xFFFFFF80))
    end
end

--- Update.
-- Also used by ScreenManager, called after Render
function DebugStuff.Update()
    if not DebugStuff.enabled then return end
    -- Console Toggle (L+Start)
    if DebugStuff.allowConsoleToggle and keys.down.start and keys.held.l then
        DebugStuff.consoleState = not DebugStuff.consoleState
        if DebugStuff.consoleState then
            gfx.console(nil, true)
        else
            gfx.disableConsole()
        end
    end
    -- Log Toggle
    if DebugStuff.allowLogToggle and keys.down.select and keys.held.l then
        DebugStuff.saveLogs = not DebugStuff.saveLogs
        if DebugStuff.saveLogs then
            _f = io.open(DebugStuff.logFile, "a")
            _f:write("\n** Logging Enabled (", os.date("%c"),") **\n\n")
        else
            _f:write("\n** Logging Disabled (", os.date("%c"),") **\n")
            _f:close()
        end
    end
end

return DebugStuff
