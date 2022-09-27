--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

WinState = Class{__includes = BaseState}

function WinState:enter(params)
    self.player = params.player
end

function WinState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start')
    end

    if love.keyboard.wasPressed('x') then
        self.player.levelNum = 1
        self.player.newGameNum = self.player.newGameNum + 1
        gStateMachine:change('play', {player = self.player})
    end
end

function WinState:render()
    love.graphics.draw(gTextures['menu-background'], 0, 0, 0, 
        VIRTUAL_WIDTH / gTextures['menu-background']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['menu-background']:getHeight())

    love.graphics.setFont(gFonts['freedom'])
    love.graphics.setColor(175/255, 53/255, 42/255, 1)
    love.graphics.printf('You Won', 2, VIRTUAL_HEIGHT / 2 - 62, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(255, 255, 0, 1)
    love.graphics.printf('You Won', 0, VIRTUAL_HEIGHT / 2 - 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['freedom-small'])
    love.graphics.printf('Press X to start next NG+', 0, VIRTUAL_HEIGHT / 2 + 32, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter to Play Again', 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')
end