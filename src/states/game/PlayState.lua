--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.player = params.player
    self.camX = 0
    self.camY = 0
    self.lastPlayerX = self.player.x
    self.lastPlayerY = self.player.y
    self.level = Level(self.player)
    self.background = ''
    
    if self.player.levelNum == 1 then
        self.background = 'background-grass'
    elseif self.player.levelNum == 2 then
        self.background = 'background-desert'
    else
        self.background = 'background-castle'
    end
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
    if self.player.levelNum == 2 then
        self.background = 'background-desert'
    elseif self.player.levelNum == 3 then
        self.background = 'background-castle'
    end
    -- render level and all entities separate from hearts GUI
    love.graphics.draw(gTextures[self.background], 0, 0, 0, 
    VIRTUAL_WIDTH / gTextures[self.background]:getWidth(),
    VIRTUAL_HEIGHT / gTextures[self.background]:getHeight())
    love.graphics.push()
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    self.level:render()
    love.graphics.pop()

    love.graphics.setFont(gFonts['freedom-small'])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('Slimes: ' .. tostring(math.min(self.level.numEntitiesKilled, WIN_CONDITION)) 
        .. '/ ' ..tostring(WIN_CONDITION), 2, 10, VIRTUAL_WIDTH - 10, 'right')
    love.graphics.printf('ATK: ' .. tostring(self.player.atkPots), 2, VIRTUAL_HEIGHT - 35, VIRTUAL_WIDTH - 10, 'right')
    love.graphics.printf('SPD: ' .. tostring(self.player.spdPots), 2, VIRTUAL_HEIGHT - 20, VIRTUAL_WIDTH - 10, 'right')
    if self.player.newGameNum >= 2 then
        love.graphics.printf('NG+' .. tostring(self.player.newGameNum - 1), 2, 10, VIRTUAL_WIDTH - 10, 'left')
    end
end