require "transform"
require "key_events"
require "draw"

function love.load()
  -- The debugging code
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  --[[ The definition of the points
  pointsCoord = {
    {0, 0, 3},
    {1, 0, 3},
    {0, 1, 3},
    {1, 1, 3},
    {0, 0, 4},
    {1, 0, 4},
    {0, 1, 4},
    {1, 1, 4},
  }  --]]
  -- z = 1.0 -> z = 100ly
  pointsCoord = {
    { 0.0,  0.0,  0.00},  -- Sun (X)
    {-1.2, -2.0,  6.24},  -- Betelgeuse (X)
    { 1.5,  2.0,  7.72},  -- Rigel (X)
    { 0.3, -0.7,  2.45},  -- Bellatrix (X)
    { 0.5, -0.2,  9.16},  -- Mintaka (X)
    { 0.0,  0.0, 13.42},  -- Alnilam (X)
    {-0.5,  0.2,  8.00},  -- Alnitak (X)
    {-1.0,  2.0,  6.50},  -- Saiph (X)
    { 0.0, -4.5, 10.42},  -- Meissa (X)
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
    miscCamKeys()
  end
end


function love.draw()
  drawPoints()
  drawCamData()
end