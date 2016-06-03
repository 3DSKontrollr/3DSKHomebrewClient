--- 3DSKontrollr Common Module
-- Shared constants to make communication with the server easier
-- @module Common
local Common = {}

-- Input.Buttons Enum
Common.Buttons = {
    None = 0,
    A = 1,
    B = 2,
    X = 4,
    Y = 8,
    DPadUp = 16,
    DPadDown = 32,
    DPadLeft = 64,
    DPadRight = 128,
    L = 256,
    R = 512,
    ZL = 1024,
    ZR = 2048,
    Select = 4096,
    Start = 8192
}

-- Input.Axes struct
Common.Axes = {
    X = 0,
    Y = 0,
    CX = 0,
    CY = 0,
    AccelerometerX = 0,
    AccelerometerY = 0,
    AccelerometerZ = 0,
    GyroscopeRoll = 0,
    GyroscopePitch = 0,
    GyroscopeYaw = 0
}

-- Input.Sliders struct
Common.Sliders = {
    Volume = 0,
    ThreeD = 0
}

return Common;