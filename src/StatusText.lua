StatusText = Class{}

function StatusText:init(entity, text, color)
  self.entity = entity
  self.text = text
  self.y = 0
  self.show = true
  self.color = color -- RGBA array
end

function StatusText:update(dt)
  self.y = self.y + dt * TEXT_SPEED
  self.color[4] = 1 - (self.y / MAX_TEXT_TRAVEL) + 0.1
  if self.y > MAX_TEXT_TRAVEL then
    self.show = false
  end
end

function StatusText:render()
  if self.show then
    love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4])
    love.graphics.setFont(gFonts['freedom-status'])
    love.graphics.printf(self.text, math.floor(self.entity.x - self.entity.width * 0.5), math.floor(self.entity.y - self.y - 10), 1000, 'left')
    love.graphics.setColor(1, 1, 1, 1)
  end
end