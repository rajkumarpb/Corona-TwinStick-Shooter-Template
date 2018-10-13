
local clean = require("clean")

local miniMap = {}

  local mmSize = 2

  local scopeText = display.newText("2x", _CW*.964, _CH*.42, _F, 20)
        scopeText:setFillColor(.7, .7, .7)

  local miniMap = display.newGroup()
        miniMap.anchorX, miniMap.anchorY = 1, 0
        miniMap.x, miniMap.y = _R-20, _T+20
        miniMap.xScale = 1/20
        miniMap.yScale = 1/20

  local mmFrame = display.newContainer(miniMap, 2500, 2500)
        mmFrame.anchorX, mmFrame.anchorY = 1, 0

  local overlay = display.newRect(_CW*.001, _CH*.001, 2500, 2500)
        overlay:setFillColor(0, 0, 0, .3)
        overlay.strokeWidth = 50
        overlay:setStrokeColor(0, 0, 0)
        mmFrame:insert(overlay)
        overlay.name = "zoom"

  
  local function mmEnterFrame(self)
    if (self.removeSelf == nil or
      not self.myObj or
      self.myObj.removeSelf == nil) then
        Runtime:removeEventListener("enterFrame", self)
        clean.cleanObj(self)
        return
    end
    if self.myObj == ship and ship.alive == true then
      self.rotation = ship.rotation
    end
    if ship.alive == true then
      self.x = self.myObj.x-ship.x
      self.y = self.myObj.y-ship.y
    else
      self.x = self.myObj.x-_CX
      self.y = self.myObj.y-_CY
    end
  end


  local function zoomMap(event)
    print("taps", mmSize)
    if (event.target.name == "zoom") then
      if mmSize == 2 then
        mmSize = 1 -- 4x
        scopeText.text = "4x"
        -- transition.to(miniMap, {time=200, xScale=1/40, yScale=1/40})
        -- transition.to(mmFrame, {time=200, width=mmFrame.width*2, height=mmFrame.height*2})
        -- transition.to(overlay, {time=200, width=overlay.width*2, height=overlay.height*2})
        --overlay.strokeWidth = 400
        ship.mini.xScale, ship.mini.yScale = 2, 2
        --asteroid[5].mini.xScale = 2
        --satellite.mini.xScale, satellite.mini.yScale = 2, 2

        miniMap.xScale = 1/40
        miniMap.yScale = 1/40
        mmFrame.width = mmFrame.width*2
        mmFrame.height = mmFrame.height*2
        overlay.width = overlay.width*2
        overlay.height = overlay.height*2
      elseif mmSize == 1 then
        mmSize = 3 -- 1x
        scopeText.text = "1x"
        miniMap.xScale = 1/10
        miniMap.yScale = 1/10
        mmFrame.width = mmFrame.width/4
        mmFrame.height = mmFrame.height/4
        overlay.width = overlay.width/4
        overlay.height = overlay.height/4
        ship.mini.xScale, ship.mini.yScale = .5, .5
        --asteroid[i].mini.xScale, asteroid[i].mini.yScale = .5, .5
        --satellite.mini.xScale, satellite.mini.yScale = .5, .5
      elseif mmSize == 3 then
        mmSize = 2 -- 2x
        scopeText.text = "2x"
        miniMap.xScale = 1/20
        miniMap.yScale = 1/20
        mmFrame.width = mmFrame.width*2
        mmFrame.height = mmFrame.height*2
        overlay.width = overlay.width*2
        overlay.height = overlay.height*2
        ship.mini.xScale, ship.mini.yScale = 1, 1
        --asteroid[i].mini.xScale, asteroid[i].mini.yScale = 1, 1
        --satellite.mini.xScale, satellite.mini.yScale = 1, 1
      end
    end
  end


  overlay:addEventListener("tap", zoomMap)
 

  
  
  miniMap.overview = overview
  miniMap.mmEnterFrame = mmEnterFrame
  miniMap.mmFrame = mmFrame
  miniMap.zoomMap = zoomMap

return miniMap