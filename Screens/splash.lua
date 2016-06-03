--- Splash Screen
-- @module SplashScreen
local SplashScreen = {}

local gfx = require("ctr.gfx")
local hid = require("ctr.hid")
local ui = require("Modules/UI")
local SM = require("Modules/ScreenManager")
local theme = require("Modules/themes").current

SplashScreen.time = 0;

function SplashScreen:Load()
    self.icon = gfx.texture.load("Resources/Texture/3dskicon_nobg.png")
    self.tblFont = gfx.font.load("Resources/Font/korunishi.ttf")
end

function SplashScreen:Unload()
    self.icon:unload()
    self.tblFont:unload()
end

function SplashScreen:RenderTopScreen()
    theme.topScreenBG:draw(0,0)
    gfx.text(80,105, "3DSKontrollr", 32)
    self.icon:draw(258,92)
end

function SplashScreen:RenderBottomScreen()
    theme.bottomScreenBG:draw(0,0)
    gfx.text(190, 210, "thebit.link", 18, nil, self.tblFont)
end

function SplashScreen:PostRender()
    if gfx.getFPS() <= 1 then return end
    self.time = self.time + (1000/gfx.getFPS())
    if self.time >= 5000 or DEBUG then -- 5 seconds
        SM:LoadScreen("test")
        self.time = 0 -- Just in case
    end
end

return SplashScreen