do
  -- Define the needed constants
  local fov = math.rad(90)
  local znear, zfar = 0.1, 1000
  
  function coordTrans(x, y, z)
    -- Calculate temporary values to simplify the final coord manipulation
    local w, h = love.graphics.getDimensions()
    local a = w / h
    local f = 1 / math.tan(fov/2)
    local q = zfar / (zfar-znear)
    
    -- The actual coord manipulation happens here
    local nx = a*f*x / notZero(z)
    local ny = f*y / notZero(z)
    local nz = (z*q - znear*q) / notZero(z)
    
    -- Only render the point, if it is inside the plane defined by zfar and znear
    if z >= znear and z <= zfar then
      return nx, ny, nz
    end
  end
end

function notZero(n)
  if n == 0 then
    return 1
  else
    return n
  end
end


function transAllPoints(points)
  local rv = {}
  -- Feed every point to coordTrans()
  for i,v in pairs(points) do
    local tx, ty, tz = unpack(v)
    local nx, ny, nz = coordTrans(tx, ty, tz)
    -- Only append the point to the list, if coordTrans() has decided to render them 
    if nx and ny and nz then
      rv[i] = {nx, ny, nz}
    end
  end
  return rv
end


function get2Dcoords(input)
  local points = applyCameraPos(input)
  local trans  = transAllPoints(points)
  local coords = {}
  local labels = {}
  local w, h   = love.graphics.getDimensions()
  -- transAllPoints() only return coords between -1 and 1
  for i,v in pairs(trans) do
    local x = (v[1]+1) * w/2
    local y = (v[2]+1) * h/2
    -- Append the coords to the list of points to draw
    table.insert(coords, x)
    table.insert(coords, y)
    -- There is also a list of coords for the labels
    labels[i] = {x, y}
  end
  return coords, labels
end


function applyCameraPos(input)
  local output, temp = {}, nil
  local co, cr = camOffset, camRotation
  for i,_ in pairs(input) do
    temp      = vectorAddition(input[i], co)
    output[i] = applyCameraRotation(temp, cr)
    --temp      = applyCameraRotation(input[i], cr)
    --output[i] = vectorAddition(temp, co)
  end
  return output
end

function vectorAddition(v1, v2)
  local ov = {}
  for i,_ in ipairs(v1) do
    ov[i] = v1[i] + v2[i]
  end
  return ov
end

function applyCameraRotation(coord, rot)
  local x, y, z = unpack(coord)
  local x, y, z = rotCamX(x, y, z, rot[1])
  local x, y, z = rotCamY(x, y, z, rot[2])
  local x, y, z = rotCamZ(x, y, z, rot[3])
  return {x, y, z}
end

do
  local rad, sin, cos = math.rad, math.sin, math.cos
  
  function rotCamX(x, y, z, d)
    local r  =  rad(d)
    local nx =  x
    local ny =  y*cos(r) - z*sin(r)
    local nz =  y*sin(r) + z*cos(r)
    return nx, ny, nz
  end
  
  function rotCamY(x, y, z, d)
    local r  =  rad(d)
    local nx =  x*cos(r) + z*sin(r)
    local ny =  y
    local nz = -x*sin(r) + z*cos(r)
    return nx, ny, nz
  end
  
  function rotCamZ(x, y, z, d)
    local r  =  rad(d)
    local nx =  x*cos(r) - y*sin(r)
    local ny =  x*sin(r) + y*cos(r)
    local nz =  z
    return nx, ny, nz
  end
end


function applyInverseCameraRotation(coord, rot)
  local x, y, z = unpack(coord)
  local x, y, z = invRotCamX(x, y, z, rot[1])
  local x, y, z = invRotCamY(x, y, z, rot[2])
  local x, y, z = invRotCamZ(x, y, z, rot[3])
  return {x, y, z}
end

do
  local rad, sin, cos = math.rad, math.sin, math.cos
  
  function invRotCamX(x, y, z, d)
    local r  =  rad(d)
    local nx =  x
    local ny = -y*cos(r) + z*sin(r)
    local nz = -y*sin(r) - z*cos(r)
    return nx, ny, nz
  end
  
  function invRotCamY(x, y, z, d)
    local r  =  rad(d)
    local nx = -x*cos(r) - z*sin(r)
    local ny =  y
    local nz =  x*sin(r) - z*cos(r)
    return nx, ny, nz
  end
  
  function invRotCamZ(x, y, z, d)
    local r  =  rad(d)
    local nx = -x*cos(r) + y*sin(r)
    local ny = -x*sin(r) - y*cos(r)
    local nz =  z
    return nx, ny, nz
  end
end