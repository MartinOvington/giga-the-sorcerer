--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GAME_OBJECT_DEFS = {
    ['switch'] = {
        type = 'switch',
        texture = 'switches',
        frame = 2,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 2
            },
            ['pressed'] = {
                frame = 1
            }
        }
    },
    ['heart'] = {
        type = 'heart',
        texture = 'hearts',
        frame = 5,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unpicked',
        states = {
            ['unpicked'] = {
                frame = 5
            },
            ['picked'] = {
                frame = 1
            }
        }
    },
    ['shot'] = {
        type = 'shot',
        texture = 'projectile',
        frame = 1,
        width = 12,
        height = 12,
        solid = false,
        defaultState = 'live',
        states = {
            ['live'] = {
                frame = 1
            },
        }
    }
}