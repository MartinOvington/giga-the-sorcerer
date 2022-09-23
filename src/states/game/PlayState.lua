--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.player = Player {
        animations = ENTITY_DEFS['player'].animations,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        
        x = VIRTUAL_WIDTH / 2 - 8,
        y = VIRTUAL_HEIGHT / 2 - 11,
        
        width = 12,
        height = 16,

        -- one heart == 2 health
        health = 6,

        -- rendering and collision offset for spaced sprites
        offsetY = 6,
    }
    self.camX = 0
    self.camY = 0
    self.lastPlayerX = self.player.x
    self.lastPlayerY = self.player.y
    self.level = Level(self.player)
    
    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player, self.level) end,
        ['idle'] = function() return PlayerIdleState(self.player) end,
        ['shoot-idle'] = function() return PlayerShootIdleState(self.player, self.level) end,
        ['shoot-walk'] = function() return PlayerShootWalkState(self.player, self.level) end
    }
    self.player:changeState('idle')
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.level:update(dt)
    self:updateCamera()
end

function PlayState:updateCamera()

    self.camX = self.camX + (self.player.x - self.lastPlayerX)
    self.camY = self.camY + (self.player.y - self.lastPlayerY)
    self.lastPlayerX = self.player.x
    self.lastPlayerY = self.player.y
end

function PlayState:render()
    -- render level and all entities separate from hearts GUI
    love.graphics.draw(gTextures['background'], 0, 0, 0, 
    VIRTUAL_WIDTH / gTextures['background']:getWidth(),
    VIRTUAL_HEIGHT / gTextures['background']:getHeight())
    love.graphics.push()
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    self.level:render()
    love.graphics.pop()

    love.graphics.setFont(gFonts['freedom-small'])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('Enemies: ' .. tostring(self.level.numEntitiesLeft), 2, 10, VIRTUAL_WIDTH - 10, 'right')
end