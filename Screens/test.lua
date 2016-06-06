--- Test Screen
-- The place to do well, tests...
-- @module TestScreen
local TestScreen = {}

local gfx = require("ctr.gfx")
local hid = require("ctr.hid")
local ui = require("Modules/UI")
local SM = require("Modules/ScreenManager")
local SB = require("Modules/StatusBar")
local ReportGenerator = require("Core/ReportGenerator")
local theme = require("Modules/themes").current

-- Put your computer's IP address here
local serverIp = "192.168.0.106"

function TestScreen:Init()

end
-- Top Screen
function TestScreen:RenderTopScreen()
    theme.topScreenBG:draw(0,0)
    SB.Render()
end

local frames = 0
local prevR = ""

-- Bottom Screen
function TestScreen:RenderBottomScreen()
    theme.bottomScreenBG:draw(0,0)
    keys = hid.keys()
    if ui.Button(32,180-48,256,32,"About") then
        SM:LoadScreen("splash")
    end
    if ui.Button(32,180-96,256,32,"Toggle Sensors") then
        ReportGenerator.accelEnabled = not ReportGenerator.accelEnabled
        ReportGenerator.gyroEnabled = not ReportGenerator.gyroEnabled
    end
    if ui.Button(32,180,256,32,"Keyboard Test") then
        SM:LoadScreen("keybtest")
    end
    local rep = ReportGenerator.GenerateReport()
    gfx.text(2,2, rep)
    frames = frames+1
    if rep ~= prevR or frames >= 60 then
        pcall(function()
            udp:sendto(rep,serverIp,33333)
        end)
        frames = 0
    end
    prevR = rep
end

return TestScreen
