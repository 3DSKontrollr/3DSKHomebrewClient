--- Virtual Keyboard module.
-- Provides a numeric touch keyboard.
-- A full QWERTY keyboard might be done at some point, but it's not needed right now
-- @module VirtualKeyboard
local VirtualKeyboard = {}
local gfx = require("ctr.gfx")
local UI = require("Modules/UI")
local theme = require("Modules/themes").current

--- Numeric Keyboard Object.
-- @type NumericKeyboard
local nKeyboard = {}

--- Defines if the keyboard shall render.
nKeyboard.isOpen = false
--- Contains whatever is written with the keyboard.
nKeyboard.value = ""
nKeyboard._tempVal = ""
--- "Event" to execute when a key is pressed. Must be a function.
-- Keyboard is passed as first parameter and the pressed key as second parameter.
nKeyboard.onKeyPress = nil
--- Character limit for the keyboard.
nKeyboard.maxLength = 35
--- Pattern for keyboard input.
nKeyboard.pattern = ".*"
--- Show the dot character.
nKeyboard.allowDot = true
--- Text to display above the input field.
nKeyboard.hint = ""

--- Renders the keyboard (if it's open and current screen is bottom screen).
function nKeyboard:Render()
    if not self.isOpen or UI.isTopScreen then return false end
    -- text field
    gfx.rectangle(0,0,320,75,0,theme.kbTextBackground)
    gfx.text(2,2,self.hint)
    gfx.line(20,60,300,60, 2)
    gfx.text(18,42,self._tempVal)
    -- background
    gfx.rectangle(0,75,320,165,0,theme.kbBackground)
    -- Keys
    if UI.Button(50,90,70,32,"1",true,false,18)   then self:KeyPress("1") end -- 1
    if UI.Button(123,90,70,32,"2",true,false,18)  then self:KeyPress("2") end -- 2
    if UI.Button(196,90,70,32,"3",true,false,18)  then self:KeyPress("3") end -- 3
    if UI.Button(50,126,70,32,"4",true,false,18)  then self:KeyPress("4") end -- 4
    if UI.Button(123,126,70,32,"5",true,false,18) then self:KeyPress("5") end -- 5
    if UI.Button(196,126,70,32,"6",true,false,18) then self:KeyPress("6") end -- 6
    if UI.Button(50,162,70,32,"7",true,false,18)  then self:KeyPress("7") end -- 7
    if UI.Button(123,162,70,32,"8",true,false,18) then self:KeyPress("8") end -- 8
    if UI.Button(196,162,70,32,"9",true,false,18) then self:KeyPress("9") end -- 9
    if self.allowDot then
        if UI.Button(50,198,70,32,".",true,false,18)  then self:KeyPress(".") end -- Dot
    end
    if UI.Button(123,198,70,32,"0",true,false,18) then self:KeyPress("0") end -- 0
    if UI.Button(196,198,70,32,"",true,false,18) then self:Backspace() end -- Backspace
    -- Backspace Texture
    theme.keyboardBs:draw(218,206)
    return true
end

--- Keeps track of key presses and triggers the onKeyPress event (if any).
function nKeyboard:KeyPress(key)
    if string.len(self._tempVal) < self.maxLength then
        self._tempVal = self._tempVal..key
    end
    if self.onKeyPress ~= nil then
        pcall(function() self:onKeyPress(key) end)
    end
end

--- Deletes one character and triggers the onKeyPress event (if any).
function nKeyboard:Backspace()
    self._tempVal = string.sub(self._tempVal, 1, -2)
    if self.onKeyPress ~= nil then
        pcall(function() self:onKeyPress("backspace") end)
    end
end

--- Confirms Keyboard input and closes it.
-- If the input doesn't match the pattern, it will not do anything.
-- TODO: Give some kind of feedback when the text doesn't match the pattern.
function nKeyboard:Confirm()
    if string.match(self._tempVal, self.pattern) ~= nil then
        self.value = self._tempVal
        self.isOpen = false
        return true
    else
        return false
    end
end

--- Discards Keyboard input and closes it.
function nKeyboard:Close()
    self._tempVal = ""
    self.isOpen = false
end

--- Opens the keyboard.
function nKeyboard:Open()
    self.isOpen = true
end

--- Create a new numeric keyboard
function VirtualKeyboard.CreateNumeric()
    local nk = {}
    setmetatable(nk, nKeyboard)
    nKeyboard.__index = nKeyboard
    return nk
end

return VirtualKeyboard
