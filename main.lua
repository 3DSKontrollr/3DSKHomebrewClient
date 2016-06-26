local ctr = require("ctr")
local ptm = require("ctr.ptm")
local gfx = require("ctr.gfx")
local hid = require("ctr.hid")
local font = require("ctr.gfx.font")
local fs = require("ctr.fs")
local socket = require("ctr.socket")
local screenManager = require("Modules/ScreenManager")

-- Make debug a global variable
debug = require("Core/DebugStuff")

_3DSKVERSION = "0.1.0"

-- GFX Defaults
font.setSize(14)
font.setDefault(font.load("Resources/Font/roboto.ttf"))

-- Sockets
socket.init()
udp = socket.udp()

ptm.init()

-- Screen Manager
screenManager:Init()
screenManager:LoadScreen("test")

-- Debugging
debug.Init()
debug.Write("\n-- Starting 3DSKontrollr+ Homebrew Client v0.1 --\n","(", os.date("%c"), ")\n\n")

-- The Main Loop
while ctr.run() do
    hid.read()
    -- Exit on Start+Select
    keys = hid.keys()
    if keys.held.start and keys.held.select then
        socket.shutdown()
        ptm.shutdown()
        break
    end

    -- ScreenManager is all we need
    screenManager:Render()
end
