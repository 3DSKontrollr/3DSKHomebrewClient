local ctr = require("ctr")
local gfx = require("ctr.gfx")
local hid = require("ctr.hid")
local font = require("ctr.gfx.font")
local fs = require("ctr.fs")
local socket = require("ctr.socket")
local screenManager = require("Modules/ScreenManager")

-- GFX Defaults
font.setSize(14)
font.setDefault(font.load("Resources/Font/roboto.ttf"))

-- Sockets
socket.init()
udp = socket.udp()
--tcp = socket.tcp()
--tcp:bind(3333)
connection = {}

-- Screen Manager
screenManager:Init()
screenManager:LoadScreen("test")

-- Debug Mode
DEBUG = true
CONSOLE = false

-- The Main Loop
while ctr.run() do
    -- Exit on Start+Select
    hid.read()
    keys = hid.keys()
    if keys.held.start and keys.held.select then
        socket.shutdown()
        break
    end
    -- Toggle console with L+Start in debug mode
    if DEBUG and keys.down.start and keys.held.l then
        if CONSOLE then
            CONSOLE=false
            gfx.disableConsole()
        else
            CONSOLE=true
            gfx.console()
        end
    end
    -- ScreenManager is all we need
    screenManager:Render()
end