function drawPoints(points)
  love.graphics.setPointSize(4.0)
  love.graphics.points(points)
end

function drawStarLabels(labels)
  local p = pointsCoord
  for t,v in pairs(labels) do
    -- The coords of the labels are identical with the ones of the stars (+ a little offset)
    local x, y = v[1]+5, v[2]+5
    -- z = 1.0 -> z = 100ly
    local   pz = p[t][3] * 100
    local name = t .." (".. pz .."ly)"
    love.graphics.print(name, x,y)
  end
end

function drawCamData()
  local ox, oy, oz = unpack(camOffset)
  local rx, ry, rz = unpack(camRotation)
  local comma, degree = ", ", "°, "
  local pos_line = "Position: " ..ox..comma  ..oy..comma  ..oz
  local rot_line = "Rotation: " ..rx..degree ..ry..degree ..rz .."°"
  love.graphics.print(pos_line, 10,10)
  love.graphics.print(rot_line, 10,30)
end