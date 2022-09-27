--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

NextLevelState = Class{__includes = BaseState}

function NextLevelState:enter(params)
    self.player = params.player
    self.player.x = VIRTUAL_WIDTH / 2 - 8
    self.player.y = VIRTUAL_HEIGHT / 2 - 11
end

function NextLevelState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        if self.player.levelNum == 3 then
            gStateMachine:change('win', {player = self.player})
        else
            self.player.levelNum = self.player.levelNum + 1
            gStateMachine:change('play', {player = self.player})
        end
    end
end

function NextLevelState:render()
    love.graphics.draw(gTextures['menu-background'], 0, 0, 0, 
        VIRTUAL_WIDTH / gTextures['menu-background']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['menu-background']:getHeight())

    love.graphics.setFont(gFonts['freedom'])
    love.graphics.setColor(175/255, 53/255, 42/255, 1)
    love.graphics.printf('Completed level ' .. tostring(self.player.levelNum), 2, VIRTUAL_HEIGHT / 2 - 62, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(255, 255, 0, 1)
    love.graphics.printf('Completed level ' .. tostring(self.player.levelNum), 0, VIRTUAL_HEIGHT / 2 - 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['freedom-small'])
    love.graphics.printf('Press Enter to continue', 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')
end