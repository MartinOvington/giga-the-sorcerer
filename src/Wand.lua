
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

function Wand:render(camX, camY)
  love.graphics.draw(gTextures['projectile'], gFrames['projectile'][2], 
  math.floor(camX + self.x - TILE_SIZE / 2), math.floor(camY + self.y - TILE_SIZE / 2))
end