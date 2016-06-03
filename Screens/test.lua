--- Test Screen
-- The place to do well, tests...
-- @module TestScreen
local TestScreen = {}

local gfx = require("ctr.gfx")
local hid = require("ctr.hid")
local ui = require("Modules/UI")
local SM = require("Modules/ScreenManager")
local ReportGenerator = require("Core/ReportGenerator")

function TestScreen:Init()
    
end
-- Top Screen
function TestScreen:RenderTopScreen()
    
end

function getBytes(num)
    return math.floor(num / 2^24), math.floor((num % 2^24) / 2^16),
           math.floor((num % 2^16) / 2^8), num % 2^8
end

function sensorToBytes(x,y,z)
    x = math.floor(((x/1000)*127) + 128)
    y = math.floor(((y/1000)*127) + 128)
    z = math.floor(((z/1000)*127) + 128)
    return x,y,z
end

local frames = 0

local prevR = ""

-- Bottom Screen
function TestScreen:RenderBottomScreen()
    keys = hid.keys()
    if ui.Button(4,180-48,256,32,"About") then
        SM:LoadScreen("splash")
    end
    if ui.Button(4,180-96,256,32,"Toggle Sensors") then
        ReportGenerator.accelEnabled = not ReportGenerator.accelEnabled
        ReportGenerator.gyroEnabled = not ReportGenerator.gyroEnabled
    end
    local rep = ReportGenerator.GenerateReport()
    gfx.text(2,2, rep)
    frames = frames+1
    if rep ~= prevR or frames >= 60 then
        udp:sendto(rep,"192.168.0.106",33333)
        frames = 0
    end
    prevR = rep
end

return TestScreen