--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self.level = 1
    self.wand = Wand()
    self.wand:init()
    self.dmg = def.dmg or 0.5
    self.shot_cooldown = 0
end

function Player:faceMouse()
    local midX = VIRTUAL_WIDTH / 2
    local midY = VIRTUAL_HEIGHT / 2
    local direction = 'left'
    -- find quadrant then compare mouse x and y
    if self.wand.x < midX and self.wand.y < midY then
        -- top-left quadrant
        if (midX - self.wand.x) > (midY - self.wand.y) then
            self.direction = 'left'
        else
            self.direction = 'up'
        end
    elseif self.wand.x >= midX and self.wand.y < midY then
    -- top-right quadrant
        if (self.wand.x - midX) > (midY - self.wand.y) then
            self.direction = 'right'
        else
            self.direction = 'up'
        end
    elseif self.wand.x > midX and self.wand.y >= midY then
    -- bottom-right quadrant
        if (self.wand.x - midX) > (self.wand.y - midY) then
            self.direction = 'right'
        else
            self.direction = 'down'
        end
    else
        -- bottom-left quadrant
        if (midX - self.wand.x) > (self.wand.y - midY) then
            self.direction = 'left'
        else
            self.direction = 'down'
        end
    end
    self:changeAnimation('idle-' .. self.direction)
end

function Player:update(dt)
    self.wand:update(dt)
    Entity.update(self, dt)
end

function Player:collides(target)
    local selfY, selfHeight = self.y + self.height / 2, self.height - self.height / 2
    
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                selfY + selfHeight < target.y or selfY > target.y + target.height)
end

function Player:heal()
    self.health = math.min(6, self.health + 2)
end

function Player:incDmg()
    self.dmg = self.dmg + POT_DMG_INCREASE
end

function Player:incSpd()
    self.walkSpeed = self.walkSpeed + POT_SPD_INCREASE
end

function Player:render()
    Entity.render(self)
    
    --love.graphics.setColor(255, 0, 255, 255)
    --love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    --love.graphics.setColor(255, 255, 255, 255)
end