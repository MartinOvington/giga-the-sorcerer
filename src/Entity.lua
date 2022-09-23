--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Entity = Class{}

function Entity:init(def)

    -- in top-down games, there are four directions instead of two
    self.direction = 'down'

    self.animations = self:createAnimations(def.animations)

    -- dimensions
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height

    -- drawing offsets for padded sprites
    self.offsetX = def.offsetX or 0
    self.offsetY = def.offsetY or 0

    self.walkSpeed = def.walkSpeed

    self.maxHealth = def.health
    self.health = def.health

    -- flags for flashing the entity when hit
    self.invulnerable = false
    self.invulnerableDuration = 0
    self.invulnerableTimer = 0

    -- timer for turning transparency on and off, flashing
    self.flashTimer = 0

    self.dead = false
    self.agroTimer = AGRO_START_GRACE
    self.agro = false
    self.player = def.player
end

function Entity:checkSetAgro()
    if not self.player or self.agroTimer > 0 then
        return
    elseif math.sqrt((self.x - self.player.x) * (self.x - self.player.x) + (self.y - self.player.y) * (self.y - self.player.y))
            <= AGRO_RANGE then
        self.agro = true
        self.walkSpeed = AGRO_WALK_SPEED
    else
        self.agro = false
    end
end

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture or 'entities',
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end

    return animationsReturned
end

--[[
    AABB with some slight shrinkage of the box on the top side for perspective.
]]
function Entity:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

function Entity:damage(dmg)
    self.health = self.health - dmg
end

function Entity:goInvulnerable(duration)
    self.invulnerable = true
    self.invulnerableDuration = duration
end

function Entity:changeState(name)
    self.stateMachine:change(name)
end

function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Entity:update(dt)
    if self.invulnerable then
        self.flashTimer = self.flashTimer + dt
        self.invulnerableTimer = self.invulnerableTimer + dt

        if self.invulnerableTimer > self.invulnerableDuration then
            self.invulnerable = false
            self.invulnerableTimer = 0
            self.invulnerableDuration = 0
            self.flashTimer = 0
        end
    end
    self:checkSetAgro()
    self.agroTimer = math.max(self.agroTimer - dt, 0)
    self.stateMachine:update(dt)

    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end
end

function Entity:processAI(params, dt)
    self.stateMachine:processAI(params, dt)
end

function Entity:render(adjacentOffsetX, adjacentOffsetY)
    
    -- draw sprite slightly transparent if invulnerable every 0.04 seconds
    if self.invulnerable and self.flashTimer > 0.06 then
        self.flashTimer = 0
        love.graphics.setColor(1, 1, 1, 64/255)
    end

    self.x, self.y = self.x + (adjacentOffsetX or 0), self.y + (adjacentOffsetY or 0)
    --if self.agro then
        --love.graphics.setColor(1, 0.3, 0.3, 1)
    --end
    self.stateMachine:render()
    love.graphics.setColor(1, 1, 1, 1)
    -- Draw health bar
    local healthRatio = self.health / self.maxHealth 
    local width = math.floor(healthRatio * 15)
    if healthRatio > 0.5 then
        love.graphics.setColor(0, 1, 0, 1)
    elseif healthRatio <= 0.25 then
        love.graphics.setColor(1, 0, 0, 1)
    else 
        love.graphics.setColor(255, 165, 0, 255)
    end
    love.graphics.rectangle('fill', math.floor(self.x - 1), math.floor(self.y + self.height + 2), width, 3)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('line', math.floor(self.x - 2), math.floor(self.y + self.height + 1), 17, 4)
    love.graphics.setColor(1, 1, 1, 1)
    self.x, self.y = self.x - (adjacentOffsetX or 0), self.y - (adjacentOffsetY or 0)
end