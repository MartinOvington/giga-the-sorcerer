--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:enter(params)
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 0
    self.entity.offsetX = 1
end

function PlayerIdleState:update(dt)
    if love.mouse.wasPressed(1) then
        if love.keyboard.isDown('w') or love.keyboard.isDown('a') or
       love.keyboard.isDown('s') or love.keyboard.isDown('d') then
            self.entity:changeState('shoot-walk')
        else
            self.entity:changeState('shoot-idle')
        end
    elseif love.keyboard.isDown('w') or love.keyboard.isDown('a') or
       love.keyboard.isDown('s') or love.keyboard.isDown('d') then
        self.entity:changeState('walk')
    end
end