local KeyboardTestScreen = {}

local gfx = require("ctr.gfx")
local hid = require("ctr.hid")
local ui = require("Modules/UI")
local SB = require("Modules/StatusBar")
local SM = require("Modules/ScreenManager")
local KB = require("Modules/VirtualKeyboard")
local theme = require("Modules/themes").current

function KeyboardTestScreen:Init()
    self.kb = KB.CreateNumeric()
    self.bg = true
    self.lastKey = ""
    self.kb.onKeyPress = function(sender,key)
        KeyboardTestScreen.lastKey = "Last pressed key: " .. key
    end
    self.kb.hint = "Enter a number"
end

function KeyboardTestScreen:RenderTopScreen()
    if self.bg then theme.topScreenBG:draw(0,0) end
    SB.Render()
    gfx.text(2,24,"Press Y to toggle background.")
    if self.kb.isOpen then gfx.text(2,64,"Press A to confirm keyboard input and B to discard it.") end
    gfx.text(2,96,self.lastKey)
end

function KeyboardTestScreen:RenderBottomScreen()
    if self.bg then theme.bottomScreenBG:draw(0,0) end
    if not self.kb:Render() then
        gfx.text(2,2,"You wrote: " .. self.kb.value)
        if ui.Button(32,180-48,256,32,"Open Keyboard") then
            self.kb:Open()
        end
        if ui.Button(32,180,256,32,"Go Back") then
            SM:LoadScreen("test")
        end
    end
end

function KeyboardTestScreen:PostRender()
    keys = hid.keys()
    if keys.down.y then self.bg = not self.bg end
    if keys.down.a then self.kb:Confirm() end
    if keys.down.b then self.kb:Close() end
end

return KeyboardTestScreen
