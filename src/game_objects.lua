--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GAME_OBJECT_DEFS = {
    ['bush'] = {
        type = 'obstacle',
        texture = 'grass-tiles',
        frame = 2,
        width = 12,
        height = 12,
        solid = true,
        defaultState = 'bush',
        states = {
            ['bush'] = {
                frame = 4
            }
        }
    },
    ['rock'] = {
        type = 'obstacle',
        texture = 'desert-tiles',
        frame = 2,
        width = 12,
        height = 12,
        solid = true,
        defaultState = 'rock',
        states = {
            ['rock'] = {
                frame = 4
            }
        }
    },
    ['gravestone'] = {
        type = 'obstacle',
        texture = 'castle-tiles',
        frame = 2,
        width = 12,
        height = 12,
        solid = true,
        defaultState = 'gravestone',
        states = {
            ['gravestone'] = {
                frame = 4
            }
        }
    },
    ['hp'] = {
        type = 'hp',
        texture = 'drops',
        frame = 5,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unpicked',
        states = {
            ['unpicked'] = {
                frame = 1
            },
            ['picked'] = {
                frame = 5
            }
        }
    },
    ['spd'] = {
        type = 'spd',
        texture = 'drops',
        frame = 5,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unpicked',
        states = {
            ['unpicked'] = {
                frame = 2
            },
            ['picked'] = {
                frame = 5
            }
        }
    },
    ['atk'] = {
        type = 'atk',
        texture = 'drops',
        frame = 5,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unpicked',
        states = {
            ['unpicked'] = {
                frame = 3
            },
            ['picked'] = {
                frame = 5
            }
        }
    },
    ['key'] = {
        type = 'key',
        texture = 'drops',
        frame = 5,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unpicked',
        states = {
            ['unpicked'] = {
                frame = 4
            },
            ['picked'] = {
                frame = 5
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