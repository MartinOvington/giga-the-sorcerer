
StartState = Class{__includes = BaseState}

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('c') then
        gStateMachine:change('controls')
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play', { player = Player {
            animations = ENTITY_DEFS['player'].animations,
            walkSpeed = ENTITY_DEFS['player'].walkSpeed,
            
            x = VIRTUAL_WIDTH / 2 - 8,
            y = VIRTUAL_HEIGHT / 2 - 11,
            
            width = 12,
            height = 16,
    
            health = 6,

            offsetY = 6,

            levelNum = 1
        }})
    end
end

function StartState:render()
    love.graphics.draw(gTextures['menu-background'], 0, 0, 0, 
        VIRTUAL_WIDTH / gTextures['menu-background']:getWidth(),
        VIRTUAL_HEIGHT / gTextures['menu-background']:getHeight())

    love.graphics.setFont(gFonts['freedom'])
    love.graphics.setColor(175/255, 53/255, 42/255, 1)
    love.graphics.printf('Giga the Sorcerer', 2, VIRTUAL_HEIGHT / 2 - 62, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 0, 1)

    love.graphics.printf('Giga the Sorcerer', 0, VIRTUAL_HEIGHT / 2 - 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['freedom-small'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 64, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press C for Controls', 0, VIRTUAL_HEIGHT / 2 + 85, VIRTUAL_WIDTH, 'center')
end