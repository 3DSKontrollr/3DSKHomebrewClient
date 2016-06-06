local color = require("ctr.gfx.color")
local font  = require("ctr.gfx.font")
local tex   = require("ctr.gfx.texture")

-- Theme support WIP
local Themes = {}

local DefaultTheme =
{
    uiBackground     = color.hex(0x111111FF),
    uiForeground     = color.hex(0xFFFFFFEE),
    uiFont           = font.getDefault(),
    kbBackground     = color.hex(0x303030B4),
    kbTextBackground = color.hex(0x000000C8),
    buttonBackground = color.hex(0x80808080),
    buttonForeground = color.hex(0xFFFFFFEE),
    buttonPressedBG  = color.hex(0xEFEFEFFF),
    buttonPressedFG  = color.hex(0x000000FF),
    statusBarBG      = color.hex(0x000000C8),
    spinnerTexture   = tex.load("Resources/Texture/spinner.png"),
    topScreenBG      = tex.load("Resources/Texture/bg_top.png"),
    bottomScreenBG   = tex.load("Resources/Texture/bg_bottom.png"),
    batteryBG        = tex.load("Resources/Texture/battery_bg.png"),
    batteryFill      = tex.load("Resources/Texture/battery_fill.png"),
    batteryCharging  = tex.load("Resources/Texture/battery_charging.png"),
    keyboardBs       = tex.load("Resources/Texture/backspace.png"),
}

Themes.default = DefaultTheme
Themes.current = DefaultTheme

return Themes
