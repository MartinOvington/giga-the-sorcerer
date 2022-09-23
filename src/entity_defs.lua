--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

ENTITY_DEFS = {
    ['player'] = {
        walkSpeed = PLAYER_WALK_SPEED,
        animations = {
            ['walk-left'] = {
                frames = {16, 17, 18, 17},
                interval = 0.155,
                texture = 'entities'
            },
            ['walk-right'] = {
                frames = {28, 29, 30, 29},
                interval = 0.15,
                texture = 'entities'
            },
            ['walk-down'] = {
                frames = {4, 5, 6, 4},
                interval = 0.15,
                texture = 'entities'
            },
            ['walk-up'] = {
                frames = {40, 41, 42, 40},
                interval = 0.15,
                texture = 'entities'
            },
            ['idle-left'] = {
                frames = {17},
                texture = 'entities'
            },
            ['idle-right'] = {
                frames = {29},
                texture = 'entities'
            },
            ['idle-down'] = {
                frames = {5},
                texture = 'entities'
            },
            ['idle-up'] = {
                frames = {41},
                texture = 'entities'
            }
        }
    },
    ['small-green-slime'] = {
        texture = 'small-green-slime',
        animations = {
            ['walk-left'] = {
                frames = {7, 8},
                interval = 0.2,
                texture = 'small-green-slime'
            },
            ['walk-right'] = {
                frames = {3, 4},
                interval = 0.2,
                texture = 'small-green-slime'
            },
            ['walk-down'] = {
                frames = {1, 2},
                interval = 0.2,
                texture = 'small-green-slime'
            },
            ['walk-up'] = {
                frames = {5, 6},
                interval = 0.2,
                texture = 'small-green-slime'
            },
            ['idle-left'] = {
                frames = {7},
                texture = 'small-green-slime'
            },
            ['idle-right'] = {
                frames = {3},
                texture = 'small-green-slime'
            },
            ['idle-down'] = {
                frames = {1},
                texture = 'small-green-slime'
            },
            ['idle-up'] = {
                frames = {5},
                texture = 'small-green-slime'
            }
        }
    },
    ['medium-green-slime'] = {
        texture = 'medium-green-slime',
        animations = {
            ['walk-left'] = {
                frames = {7, 8},
                interval = 0.2,
                texture = 'medium-green-slime'
            },
            ['walk-right'] = {
                frames = {3, 4},
                interval = 0.2,
                texture = 'medium-green-slime'
            },
            ['walk-down'] = {
                frames = {1, 2},
                interval = 0.2,
                texture = 'medium-green-slime'
            },
            ['walk-up'] = {
                frames = {5, 6},
                interval = 0.2,
                texture = 'medium-green-slime'
            },
            ['idle-left'] = {
                frames = {7},
                texture = 'medium-green-slime'
            },
            ['idle-right'] = {
                frames = {3},
                texture = 'medium-green-slime'
            },
            ['idle-down'] = {
                frames = {1},
                texture = 'medium-green-slime'
            },
            ['idle-up'] = {
                frames = {5},
                texture = 'medium-green-slime'
            }
        }
    }
}