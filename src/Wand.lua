
Wand = Class{}

function Wand:init()
  local x, y = push:toGame(love.mouse.getPosition())
  self.x = x or 0
  self.y = y or 0
end

function Wand:update(dt)
  local x, y = push:toGame(love.mouse.getPosition())
  self.x = x or 0
  self.y = y or 0
end