--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

StartState = Class{__includes = BaseState}

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function StartState:render()
    love.graphics.draw(gTextures['menu-background'], 0, 0, 0, 
        VIRTUAL_WIDTH / gTextures['menu-background']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['menu-background']:getHeight())

    love.graphics.setFont(gFonts['freedom'])
    love.graphics.setColor(34/255, 34/255, 34/255, 1)
    love.graphics.printf('Wrath of Giga', 2, VIRTUAL_HEIGHT / 2 - 62, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(175/255, 53/255, 42/255, 1)
    love.graphics.printf('Wrath of Giga', 0, VIRTUAL_HEIGHT / 2 - 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['freedom-small'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')
end