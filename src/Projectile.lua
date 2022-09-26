--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Projectile = Class{}

function Projectile:init(def, dx, dy, dmg)
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    -- whether it acts as an obstacle or not
    self.solid = def.solid

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    -- dimensions
    self.width = def.width
    self.height = def.height
    self.dx = dx
    self.dy = dy
    self.x = def.x
    self.y = def.y
    self.distTravelled = 0
    self.destroyed = false
    self.dmg = dmg or 0.5

    -- default empty collision callback
    self.onCollide = function() end
end

function Projectile:update(dt)
    if self.distTravelled >= TILE_SIZE * PROJECTILE_TRAVEL_DIST then
        self.destroyed = true
    end
    self.x = self.x + self.dx * dt * PROJECTILE_SPEED
    self.y = self.y + self.dy * dt * PROJECTILE_SPEED

    self.distTravelled = self.distTravelled + dt * PROJECTILE_SPEED

    if self.direction == 'left' then
        if self.x <= MAP_RENDER_OFFSET_X + TILE_SIZE then
            self.destroyed = true
        end
    elseif self.direction == 'right' then
        if self.x + self.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 then
            self.destroyed = true
        end
    elseif self.direction == 'up' then
        if self.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - self.height / 2 then 
            self.destroyed = true
        end
    elseif self.direction == 'down' then
        local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
            + MAP_RENDER_OFFSET_Y - TILE_SIZE

        if self.y + self.height >= bottomEdge then
            self.destroyed = true
        end
    end
end

function Projectile:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

function Projectile:render(adjacentOffsetX, adjacentOffsetY)
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame], 
        self.x + adjacentOffsetX, self.y + adjacentOffsetY)
end