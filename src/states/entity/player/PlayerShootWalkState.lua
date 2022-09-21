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

function PlayerShootIdleState:faceMouse()
    local midX = VIRTUAL_WIDTH / 2
    local midY = VIRTUAL_HEIGHT / 2
    -- find quadrant then compare mouse x and y
    if self.entity.wand.x < midX and self.entity.wand.y < midY then
        -- top-left quadrant
        if (midX - self.entity.wand.x) > (midY - self.entity.wand.y) then
            self.entity.direction = 'left'
        else
            self.entity.direction = 'up'
        end
    elseif self.entity.wand.x >= midX and self.entity.wand.y < midY then
    -- top-right quadrant
        if (self.entity.wand.x - midX) > (midY - self.entity.wand.y) then
            self.entity.direction = 'right'
        else
            self.entity.direction = 'up'
        end
    elseif self.entity.wand.x > midX and self.entity.wand.y >= midY then
    -- bottom-right quadrant
        if (self.entity.wand.x - midX) > (self.entity.wand.y - midY) then
            self.entity.direction = 'right'
        else
            self.entity.direction = 'down'
        end
    else
        -- bottom-left quadrant
        if (midX - self.entity.wand.x) > (self.entity.wand.y - midY) then
            self.entity.direction = 'left'
        else
            self.entity.direction = 'down'
        end
    end
    self.entity:changeAnimation('idle-' .. self.entity.direction)
end

function PlayerWalkState:update(dt)
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