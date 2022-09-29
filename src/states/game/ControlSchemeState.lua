
ControlSchemeState = Class{__includes = BaseState}

function ControlSchemeState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start')
    end
end

function ControlSchemeState:render()
    love.graphics.draw(gTextures['menu-background'], 0, 0, 0, 
        VIRTUAL_WIDTH / gTextures['menu-background']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['menu-background']:getHeight())

    love.graphics.setFont(gFonts['freedom'])
    love.graphics.setColor(175/255, 53/255, 42/255, 1)
    love.graphics.printf('Controls', 20, 20, VIRTUAL_WIDTH, 'left')
    love.graphics.setColor(255, 255, 0, 1)
    love.graphics.printf('Controls', 18, 18, VIRTUAL_WIDTH, 'left')

    love.graphics.setFont(gFonts['freedom-small'])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('WASD - Movement', 20, 70, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('Left-mouse - Shoot', 20, 90, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('Right-mouse - Cast Scroll', 20, 110, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('X - Open Chest', 20, 130, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('ESC - Quite Game', 20, 150, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('Press Enter to Close', 0, VIRTUAL_HEIGHT / 2 + 80, VIRTUAL_WIDTH, 'center')
end