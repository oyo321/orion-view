require "transform"
require "key_events"
require "draw"

function love.load()
  -- The debugging code
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  -- The position of the stars
  -- z = 1.0 -> z = 100ly
  pointsCoord = {
    Sun        = { 0.0,  0.0,  0.00},  -- Sun (X)
    Betelgeuse = {-1.2, -2.0,  6.24},  -- Betelgeuse (X)
    Rigel      = { 1.5,  2.0,  7.72},  -- Rigel (X)
    Bellatrix  = { 0.3, -0.7,  2.45},  -- Bellatrix (X)
    Mintaka    = { 0.5, -0.2,  9.16},  -- Mintaka (X)
    Alnilam    = { 0.0,  0.0, 13.42},  -- Alnilam (X)
    Alnitak    = {-0.5,  0.2,  8.00},  -- Alnitak (X)
    Saiph      = {-1.0,  2.0,  6.50},  -- Saiph (X)
    Meissa     = { 0.0, -4.5, 10.42},  -- Meissa (X)
  }
  -- The camera offset and rotation
  camOffset   = {0, 0, 0}
  camRotation = {0, 0, 0}  -- In degrees
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