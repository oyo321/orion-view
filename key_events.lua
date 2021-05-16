function moveCamKeys()
  local keyDown = love.keyboard.isDown
  local keys = {
    {"a", 1,  0.1}; {"d", 1, -0.1},
    {"q", 2,  0.1}; {"e", 2, -0.1},
    {"s", 3,  0.1}; {"w", 3, -0.1},
  }
  for _,k in ipairs(keys) do
    if keyDown(k[1]) then
      camOffset[k[2]] = camOffset[k[2]] + k[3]
    end
  end
end

function turnCamKeys()
  local keyDown = love.keyboard.isDown
  local keys = {
    {"k", 1,  5}; {"i", 1, -5},
    {"j", 2,  5}; {"l", 2, -5},
    {"u", 3,  5}; {"o", 3, -5},
  }
  for _,k in ipairs(keys) do
    if keyDown(k[1]) then
      camRotation[k[2]] = camRotation[k[2]] + k[3]
    end
  end
end

function miscKeys(key)
  if key == "r" then
    camOffset   = {0, 0, 0}
    camRotation = {0, 0, 0}
  elseif key == "n" then
    showStarLabels = not showStarLabels
  end
end