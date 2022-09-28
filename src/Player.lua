--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self.wand = Wand()
    self.wand:init()
    self.dmg = def.dmg or 0.5
    self.atkPots = 0
    self.spdPots = 0
    self.scrolls = 1
    self.shot_cooldown = 0
    self.levelNum = def.levelNum
    self.newGameNum = 1
end

function Player:faceMouse(animType)
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
    self:changeAnimation(animType .. self.direction)
end

function Player:tryOpenChest(level)  
    local openHitbox = Hitbox(self.x - self.width , self.y, self.width * 3, self.height * 1.5)
    for k, object in pairs(level.objects) do
        if object.state == 'closed' then
            if object:collides(openHitbox) then
                gSounds['open-chest']:play()
                object.state = 'open'
                self:incScrolls()
            end
        end
    end
end

function Player:useScroll(level)
    if self.scrolls > 0 then
        self.scrolls = self.scrolls -1
        gSounds['scroll']:stop()
        gSounds['scroll']:play()
        local angle = 0
        local x = self.x - VIRTUAL_WIDTH / 2 + self.wand.x
        local y = self.y - VIRTUAL_HEIGHT / 2 + self.wand.y
        for i = 1, SCROLL_PROJECTILES, 1 do
            table.insert(level.projectiles,
            Projectile(GameObject(GAME_OBJECT_DEFS['shot-scroll'], x, y), 
                math.cos(angle), math.sin(angle), self.dmg))
            angle = angle + SCROLL_ANGLE_INC
        end
    end
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
    table.insert(self.statusTexts, StatusText(self, '+' .. tostring(2 * 10), gColors['green-hp']))
end

function Player:incDmg()
    self.atkPots = self.atkPots + 1
    self.dmg = self.dmg + POT_DMG_INCREASE
    table.insert(self.statusTexts, StatusText(self, '+ATK', gColors['pink']))
end

function Player:incSpd()
    self.spdPots = self.spdPots + 1
    self.walkSpeed = self.walkSpeed + POT_SPD_INCREASE
    table.insert(self.statusTexts, StatusText(self, '+SPD', gColors['green-spd']))
end

function Player:incScrolls()
    self.scrolls = self.scrolls + 1
    table.insert(self.statusTexts, StatusText(self, '+Scroll', gColors['orange']))
end

function Player:render()
    Entity.render(self)
    
    --love.graphics.setColor(255, 0, 255, 255)
    --love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    --love.graphics.setColor(255, 255, 255, 255)
end