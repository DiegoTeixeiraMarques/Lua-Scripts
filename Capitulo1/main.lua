local tapCount = 0

local background = display.newImageRect( "background.png", 360, 750 )
background.x = display.contentCenterX
background.y = display.cotentCenterY

local tapText = display.newText(tapCount, display.contentCenterX, -150, native.systemFont, 40)
tapText:setFillColor( 0, 0, 0 )

local platform = display.newImageRect( "platform.png", 300, 50 )
platform.x = display.contentCenterX
platform.y = display.contentHeight+150

local balloon = display.newImageRect( "balloon.png", 112, 112 )
balloon.x = display.contentCenterX
balloon.y = display.contentCenterY

local physics = require("physics")
physics.start()

physics.addBody( platform, "static" )
physics.addBody( balloon, "dynamic", { radius=50, bounce=0.3 } )

local function pushBalloon()
	balloon:applyLinearImpulse( 0, -0.75, balloon.x, balloon.y )
	tapCount = tapCount + 1
	tapText.text = tapCount
end

balloon:addEventListener( "tap", pushBalloon)