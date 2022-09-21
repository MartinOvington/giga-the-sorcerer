--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player, dungeon)
    self.entity = player
    self.dungeon = dungeon

    -- render offset for spaced character sprite; negated in render function of state
    self.entity.offsetY = 0
    self.entity.offsetX = 1
end

function PlayerWalkState:update(dt)
    if (love.mouse.wasPressed(1) or love.mouse.isDown(1)) and 
    (love.keyboard.isDown('w') or love.keyboard.isDown('a') or
    love.keyboard.isDown('s') or love.keyboard.isDown('d')) then
        self.entity:changeState('shoot-walk')
    end
    if love.keyboard.isDown('a') then
        self.entity.direction = 'left'
        self.entity:changeAnimation('walk-left')
    elseif love.keyboard.isDown('d') then
        self.entity.direction = 'right'
        self.entity:changeAnimation('walk-right')
    elseif love.keyboard.isDown('w') then
        self.entity.direction = 'up'
        self.entity:changeAnimation('walk-up')
    elseif love.keyboard.isDown('s') then
        self.entity.direction = 'down'
        self.entity:changeAnimation('walk-down')
    else
        if love.mouse.wasPressed(1) or love.mouse.isDown(1) then
            self.entity:changeState('shoot-idle')
        else    
            self.entity:changeState('idle')
        end
    end

    -- perform base collision detection against walls
    EntityWalkState.update(self, dt)
end