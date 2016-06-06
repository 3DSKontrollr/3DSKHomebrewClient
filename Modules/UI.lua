--- Very shitty UI system.
-- Basic hit testing for now, make sure to not overlap items!
-- @module UISystem
local UISystem = {}

local Themes = require("Modules/themes")
local gfx = require("ctr.gfx")
local hid = require("ctr.hid")

--- Variables.
-- Some variables
-- @section Variables
UISystem.isTopScreen = false -- True when the screen being rendered happens to be the top screen
UISystem.lastFrameTouch = {x = 0, y = 0} -- Touch input during previous frame
UISystem.spinnerRad = 0 -- Rotation of the spinners

--- Functions.
-- Some functions
-- @section Functions

--- Update Logic.
-- This function is called once per frame, right after the CurrentScreen:PostRender function
function UISystem:Update()
    -- Make spinners spin
    self.spinnerRad = self.spinnerRad + (1000/gfx.getFPS()/1000) * 4
    if self.spinnerRad >= 3.14 then self.spinnerRad = 0 end
    -- Store the touch location for this frame
    local tx,ty = hid.touch()
    self.lastFrameTouch = {x = tx, y = ty}
end

--- Basic UI Elements.
-- We couldn't live without those
-- @section BasicUI

--- Basic Button.
-- No way to center text for nowi, sorry
-- @int x Horizontal position of the button
-- @int y Vertical position of the button
-- @int w Width of the button
-- @int h Height of the button
-- @string text Text of the button
-- @bool[opt=true] enabled Whether the button is enabled or not
-- @bool[opt] triggerOnHold If true, the function will return true when the button is being held, rather than after release only
-- @int[opt] size Font Size
-- @param[opt] theme Override theme
-- @treturn bool Returns true if the button is pressed
function UISystem.Button(x,y,w,h,text,enabled,triggerOnHold,size,theme)
    enabled = enabled or true
    triggerOnHold = triggerOnHold or false
    theme = theme or Themes.current
    size = size or gfx.font.getSize()

    local background = theme.buttonBackground
    local foreground = theme.buttonForeground
    local pressed    = false

    -- Detect if the button is being held
    local tx,ty = hid.touch()
    if enabled and not UISystem.isTopScreen and tx >= x and tx < x+w and ty >= y and ty < y+h then
        pressed = triggerOnHold
        background = theme.buttonPressedBG
        foreground = theme.buttonPressedFG
    end
    -- Detect if the button was being held the last frame (only when triggerOnHold is false)
    if not triggerOnHold and enabled and not UISystem.isTopScreen and tx <= 0 and ty <= 0 and
    UISystem.lastFrameTouch.x >= x and UISystem.lastFrameTouch.x < x+w and
    UISystem.lastFrameTouch.y >= y and UISystem.lastFrameTouch.y < y+h then
       pressed = true
    end

    -- Draw the background
    gfx.rectangle(x,y,w,h,0,background)
    -- Calculate the space the text will take
    local tbx, tby = gfx.calcBoundingBox(text, w, size, theme.uiFont)
    -- Calculate the horizontal center of the text (thanks Phalk, i used some code from your Crimson Scripter here)
    local textX = (x+w/2) - ((string.len(text)) / 2) * (size/2)
    -- Calculate the vertical center of the text
    local textY = y + (h - tby)/2
    -- Draw the text, centered vertically AND horizontally :)
    gfx.wrappedText(math.floor(textX), textY,text,w,size,foreground,theme.uiFont)
    -- Return true if the button is being held
    return pressed
end

--- Decorative Elements
-- To make the app look neat
-- @section Decorative
function UISystem.Spinner(x,y,s)
    Themes.current.spinnerTexture:draw(x,y,UISystem.spinnerRad,16,16)
end

return UISystem
