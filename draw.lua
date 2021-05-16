function drawPoints()
  local points = get2Dcoords(pointsCoord)
  love.graphics.setPointSize(5.0)
  love.graphics.points(points)
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