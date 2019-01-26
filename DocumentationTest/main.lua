local ball = display.newImage("ball.png")
ball.x = display.contentCenterX
ball.y = display.contentCenterY

local physics = require("physics")
physics.start()

physics.addBody(ball, "dynamic", {radius = 100})

