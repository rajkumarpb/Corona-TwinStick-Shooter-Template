
display.setStatusBar(display.HiddenStatusBar)
system.activate("multitouch")


local composer = require("composer")
composer.isDebug = true


_CW = display.contentWidth
_CH = display.contentHeight
_CX = display.contentWidth*0.5
_CY = display.contentHeight*0.5
_T = display.screenOriginY
_L = display.screenOriginX
_R = display.viewableContentWidth-_L
_B = display.viewableContentHeight-_T
_F =  "TitilliumWeb"


-- Collision Filters
playerFilter = {categoryBits = 1, maskBits = 22}
asteroidFilter = {categoryBits = 2, maskBits = 11}
enemyFilter  = {categoryBits = 4, maskBits = 9}
bulletFilter = {categoryBits = 8, maskbits = 6}
dropFilter = {categoryBits = 16, maskbits = 1}

-- Load Sound
sndShoot = audio.loadSound("snd/blazer.ogg")
sndLoot = audio.loadSound("snd/loot.ogg")
sndBoom = audio.loadSound("snd/boom.ogg")


-- Exiting with back-key
local function keyEvents(event)
  if (system.getInfo("platform") == "android") then
    if (event.keyName == "back") then
      return false
    end
  end
  return false
end
Runtime:addEventListener("key", keyEvents)


composer.gotoScene("play")
