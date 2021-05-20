require "init"
require "transform"
require "key_events"
require "draw"

function love.load()
  -- The debugging code
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  -- The position of the stars
  pointsCoord = initStars()
  -- The camera offset and rotation
  camOffset, camRotation = initCamera()
end

function love.update(dt)
  -- Time for the keypress interval
  keypressTime = (keypressTime or 0) + dt
  -- Every x seconds check if a keypress occured and execute the matching command, if so
  if keypressTime >= 0.05 then
    keypressTime = 0
    moveCamKeys()
    turnCamKeys()
  end
end

function love.keypressed(key)
  miscKeys(key)
end

function love.draw()
  local points, labels = get2Dcoords(pointsCoord)
  drawPoints(points)
  if showStarLabels then
    drawStarLabels(labels)
  end
  drawCamData()
end