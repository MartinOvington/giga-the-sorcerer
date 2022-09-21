--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerShootIdleState = Class{__includes = EntityIdleState}

function PlayerShootIdleState:init(player, dungeon)
    self.entity = player
    self.dungeon = dungeon
    self.entity:changeAnimation('idle-' .. self.entity.direction)
end

function PlayerShootIdleState:enter(player, dungeon)
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 0
    self.entity.offsetX = 1
    self.shot_cooldown = 0
    self:faceMouse()
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

function PlayerShootIdleState:update(dt)
    if self.entity.shot_cooldown > 0 then
        self.entity.shot_cooldown = self.entity.shot_cooldown - dt
    else
        self.entity.shot_cooldown = SHOT_COOLDOWN
        local midX = VIRTUAL_WIDTH / 2
        local midY = VIRTUAL_HEIGHT / 2
        local relativeSquaredX = (self.entity.wand.x - midX) * (self.entity.wand.x - midX)
        local relativeSquaredY = (self.entity.wand.y - midY) * (self.entity.wand.y - midY)
        vector_mag = math.sqrt(relativeSquaredX + relativeSquaredY)
        --normalize mouse vector
        local dx = (self.entity.wand.x - midX) / vector_mag
        local dy = (self.entity.wand.y - midY) / vector_mag
        gSounds['player-shoot']:play()
        table.insert(self.dungeon.currentRoom.projectiles,
            Projectile(GameObject(GAME_OBJECT_DEFS['shot'], self.entity.x, self.entity.y), dx, dy))
        self:faceMouse()
    end

    if not love.mouse.wasPressed(1) and not love.mouse.isDown(1) then
        self.entity:changeState('idle')
    elseif love.keyboard.isDown('w') or love.keyboard.isDown('a') or
       love.keyboard.isDown('s') or love.keyboard.isDown('d') then
        self.entity:changeState('walk')
    end
end