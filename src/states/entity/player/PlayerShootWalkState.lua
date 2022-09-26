--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerShootWalkState = Class{__includes = EntityWalkState}

function PlayerShootWalkState:init(player, level)
    self.entity = player
    self.level = level

    -- render offset for spaced character sprite; negated in render function of state
    self.entity.offsetY = 0
    self.entity.offsetX = 1
    self.shot_cooldown = 0
end

function PlayerShootWalkState:update(dt)
    if love.mouse.wasPressed(1) or love.mouse.isDown(1) then
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
            table.insert(self.level.projectiles,
                Projectile(GameObject(GAME_OBJECT_DEFS['shot'], self.entity.x, self.entity.y), dx, dy, self.entity.dmg))
            self.entity:faceMouse('walk-')
        end
        if love.keyboard.isDown('a') then
            self.entity.direction = 'left'
            EntityWalkState.update(self, dt)
        elseif love.keyboard.isDown('d') then
            self.entity.direction = 'right'
            EntityWalkState.update(self, dt)
        elseif love.keyboard.isDown('w') then
            self.entity.direction = 'up'
            EntityWalkState.update(self, dt)
        elseif love.keyboard.isDown('s') then
            self.entity.direction = 'down'
            EntityWalkState.update(self, dt)
        else
            self.entity:changeState('shoot-idle')
        end
    elseif love.keyboard.isDown('w') or love.keyboard.isDown('a') or
    love.keyboard.isDown('s') or love.keyboard.isDown('d') then
        self.entity:changeState('walk')
    else
        self.entity:changeState('idle')
    end

end