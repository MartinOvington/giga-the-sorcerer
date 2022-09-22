--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

EntityAgroState = Class{__includes = EntityWalkState}

function EntityAgroState:processAI(params, dt)
    local absDiffX = math.abs(self.entity.x - self.entity.player.x)
    local absDiffY = math.abs(self.entity.y - self.entity.player.y)
    if absDiffX > absDiffY then
        if self.entity.x < self.entity.player.x then
            self.entity.direction = 'right'
            self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
        else
            self.entity.direction = 'left'
            self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
        end
    else
        if self.entity.y < self.entity.player.y then
            self.entity.direction = 'down'
            self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
        else
            self.entity.direction = 'up'
            self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
        end
    end
end