--- 3DSKontrollr ReportGenerator
-- This module contains constants shared with the PC server to make communication easier.
-- @module ReportGenerator
local ReportGenerator = {}

local ctr = require("ctr")
local hid = require("ctr.hid")
local Core = require("Core/Common")
local Buttons = Core.Buttons

ReportGenerator.previousReport = ""
ReportGenerator.accelEnabled = false
ReportGenerator.gyroEnabled = false

function ReportGenerator.GenerateReport()
    -- Start with an empty string
    local d = ""
    -- Report Packet
    d=d..string.char(2)
    -- Keys
    local keys = hid.keys()
    local kdata = 0
        -- here we go...
        if keys.held.a      then kdata = kdata + Buttons.A         end -- A
        if keys.held.b      then kdata = kdata + Buttons.B         end -- B
        if keys.held.x      then kdata = kdata + Buttons.X         end -- X
        if keys.held.y      then kdata = kdata + Buttons.Y         end -- Y
        if keys.held.dUp    then kdata = kdata + Buttons.DPadUp    end -- DPad Up
        if keys.held.dDown  then kdata = kdata + Buttons.DPadDown  end -- Dpad Down
        if keys.held.dLeft  then kdata = kdata + Buttons.DPadLeft  end -- DPad Left
        if keys.held.dRight then kdata = kdata + Buttons.DPadRight end -- DPad Right
        if keys.held.l      then kdata = kdata + Buttons.L         end -- L
        if keys.held.r      then kdata = kdata + Buttons.R         end -- R
        if keys.held.zl     then kdata = kdata + Buttons.ZL        end -- ZL
        if keys.held.zr     then kdata = kdata + Buttons.ZR        end -- ZR
        if keys.held.select then kdata = kdata + Buttons.Select    end -- Select
        if keys.held.start  then kdata = kdata + Buttons.Start     end -- Start
        d=d..kdata..":"
    -- Circle Pad
        local px,py = hid.circle()
        d=d..px..":"..py..":"
    -- New 3DS C-Stick
        local cx,cy = hid.cstick()
        d=d..cx..":"..cy..":"
     -- Accelerometer
        if ReportGenerator.accelEnabled then
            local ax,ay,az = hid.accel()
            d=d..ax..":"..ay..":"..az..":"
        else
            d=d.."0:0:0:"
        end
     -- Gyroscope
        if ReportGenerator.gyroEnabled then
            local gr,gp,gy = hid.gyro()
            d=d..gr..":"..gp..":"..gy..":"
        else
            d=d.."0:0:0:"
        end
     -- Volume Slider
        d=d..math.floor((hid.volume()/63)*100)..":"
     -- 3D Slider
        d=d..math.floor(hid.pos3d()*100)
     ReportGenerator.previousReport = d
     return d
end

return ReportGenerator
