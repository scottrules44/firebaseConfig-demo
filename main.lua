local firebaseConfig = require "plugin.firebaseConfig"
firebaseConfig.init()

local widget = require("widget")

local bg = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
bg:setFillColor( 1,.5,0 )

local title = display.newText( {text = "Firebase Config", fontSize = 30} )
title.width, title.height = 300, 168
title.x, title.y = display.contentCenterX, 168*.5
title:setFillColor(1,0,0)

local getButton
getButton = widget.newButton( {
  x = display.contentCenterX,
  y = display.contentCenterY-100,
  id = "getButton",
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
  label = "Get test data",
  onEvent = function ( e )
    if (e.phase == "ended") then
      native.showAlert( "Data", firebaseConfig.getString("test") , {"Ok"} )
    end
  end
} )
local fetchButton
fetchButton = widget.newButton( {
  x = display.contentCenterX,
  y = display.contentCenterY,
  id = "fetchButton",
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
  label = "Fetch data",
  onEvent = function ( e )
    if (e.phase == "ended") then
      firebaseConfig.fetchData(function ( e )
        if (e.isError == false) then
          native.showAlert( "Got data", "", {"Ok"} )
        else
          native.showAlert( "Could not get data", "message", {"Ok"} )
        end
      end)
    end
  end
} )
