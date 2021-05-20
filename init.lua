-- START OF PROGRAM IS IN FILE "main.lua"!!!

function initStars()
  -- z = 1.0 -> z = 100ly
  return {
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
end


function initCamera()
  return {0,0,0}, {0,0,0}
end
