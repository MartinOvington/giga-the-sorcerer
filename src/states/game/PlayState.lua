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
    self.dungeon = Dungeon(self.player)
    self.currentRoom = Room(self.player)
    
    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player, self.dungeon) end,
        ['idle'] = function() return PlayerIdleState(self.player) end,
        ['shoot-idle'] = function() return PlayerShootIdleState(self.player, self.dungeon) end,
        ['shoot-walk'] = function() return PlayerShootWalkState(self.player, self.dungeon) end
    }
    self.player:changeState('idle')
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.dungeon:update(dt)
    self:updateCamera()
end

function PlayState:updateCamera()

    self.camX = self.camX + (self.player.x - self.lastPlayerX)
    self.camY = self.camY + (self.player.y - self.lastPlayerY)
    self.lastPlayerX = self.player.x
    self.lastPlayerY = self.player.y
end

function PlayState:render()
    -- render dungeon and all entities separate from hearts GUI
    love.graphics.push()
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    self.dungeon:render()
    love.graphics.pop()

    -- draw player hearts, top of screen
    local healthLeft = self.player.health
    local heartFrame = 1

    for i = 1, 3 do
        if healthLeft > 1 then
            heartFrame = 5
        elseif healthLeft == 1 then
            heartFrame = 3
        else
            heartFrame = 1
        end

        love.graphics.draw(gTextures['hearts'], gFrames['hearts'][heartFrame],
            (i - 1) * (TILE_SIZE + 1), 2)
        
        healthLeft = healthLeft - 2
    end
end