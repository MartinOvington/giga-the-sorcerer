
ENTITY_DEFS = {
    ['player'] = {
        walkSpeed = PLAYER_WALK_SPEED,
        animations = {
            ['walk-left'] = {
                frames = {4, 5, 6, 5}, 
                interval = 0.155,
                texture = 'player'
            },
            ['walk-right'] = {
                frames = {7, 8, 9, 8},
                interval = 0.15,
                texture = 'player'
            },
            ['walk-down'] = {
                frames = {1, 2, 3, 2},
                interval = 0.15,
                texture = 'player'
            },
            ['walk-up'] = {
                frames = {10, 11, 12, 11},
                interval = 0.15,
                texture = 'player'
            },
            ['idle-left'] = {
                frames = {5},
                texture = 'player'
            },
            ['idle-right'] = {
                frames = {8},
                texture = 'player'
            },
            ['idle-down'] = {
                frames = {2},
                texture = 'player'
            },
            ['idle-up'] = {
                frames = {11},
                texture = 'player'
            }
        }
    },
    ['small-green-slime'] = {
        texture = 'small-green-slime',
        slimeSize = 'small',
        walkSpeed = 20,
        health = 1,
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
        slimeSize = 'medium',
        walkSpeed = 20,
        health = 1.2,
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
    },
    ['small-blue-slime'] = {
        health = 1.3,
        texture = 'small-blue-slime',
        walkSpeed = 25,
        slimeSize = 'small',
        animations = {
            ['walk-left'] = {
                frames = {7, 8},
                interval = 0.2,
                texture = 'small-blue-slime'
            },
            ['walk-right'] = {
                frames = {3, 4},
                interval = 0.2,
                texture = 'small-blue-slime'
            },
            ['walk-down'] = {
                frames = {1, 2},
                interval = 0.2,
                texture = 'small-blue-slime'
            },
            ['walk-up'] = {
                frames = {5, 6},
                interval = 0.2,
                texture = 'small-blue-slime'
            },
            ['idle-left'] = {
                frames = {7},
                texture = 'small-blue-slime'
            },
            ['idle-right'] = {
                frames = {3},
                texture = 'small-blue-slime'
            },
            ['idle-down'] = {
                frames = {1},
                texture = 'small-blue-slime'
            },
            ['idle-up'] = {
                frames = {5},
                texture = 'small-blue-slime'
            }
        }
    },
    ['medium-blue-slime'] = {
        texture = 'medium-blue-slime',
        slimeSize = 'medium',
        walkSpeed = 25,
        health = 1.5,
        animations = {
            ['walk-left'] = {
                frames = {7, 8},
                interval = 0.2,
                texture = 'medium-blue-slime'
            },
            ['walk-right'] = {
                frames = {3, 4},
                interval = 0.2,
                texture = 'medium-blue-slime'
            },
            ['walk-down'] = {
                frames = {1, 2},
                interval = 0.2,
                texture = 'medium-blue-slime'
            },
            ['walk-up'] = {
                frames = {5, 6},
                interval = 0.2,
                texture = 'medium-blue-slime'
            },
            ['idle-left'] = {
                frames = {7},
                texture = 'medium-blue-slime'
            },
            ['idle-right'] = {
                frames = {3},
                texture = 'medium-blue-slime'
            },
            ['idle-down'] = {
                frames = {1},
                texture = 'medium-blue-slime'
            },
            ['idle-up'] = {
                frames = {5},
                texture = 'medium-blue-slime'
            }
        }
    },
    ['small-red-slime'] = {
        texture = 'small-red-slime',
        slimeSize = 'small',
        walkSpeed = 30,
        health = 1.7,
        animations = {
            ['walk-left'] = {
                frames = {7, 8},
                interval = 0.2,
                texture = 'small-red-slime'
            },
            ['walk-right'] = {
                frames = {3, 4},
                interval = 0.2,
                texture = 'small-red-slime'
            },
            ['walk-down'] = {
                frames = {1, 2},
                interval = 0.2,
                texture = 'small-red-slime'
            },
            ['walk-up'] = {
                frames = {5, 6},
                interval = 0.2,
                texture = 'small-red-slime'
            },
            ['idle-left'] = {
                frames = {7},
                texture = 'small-red-slime'
            },
            ['idle-right'] = {
                frames = {3},
                texture = 'small-red-slime'
            },
            ['idle-down'] = {
                frames = {1},
                texture = 'small-red-slime'
            },
            ['idle-up'] = {
                frames = {5},
                texture = 'small-red-slime'
            }
        }
    },
    ['medium-red-slime'] = {
        texture = 'medium-red-slime',
        slimeSize = 'medium',
        walkSpeed = 30,
        health = 1.8,
        animations = {
            ['walk-left'] = {
                frames = {7, 8},
                interval = 0.2,
                texture = 'medium-red-slime'
            },
            ['walk-right'] = {
                frames = {3, 4},
                interval = 0.2,
                texture = 'medium-red-slime'
            },
            ['walk-down'] = {
                frames = {1, 2},
                interval = 0.2,
                texture = 'medium-red-slime'
            },
            ['walk-up'] = {
                frames = {5, 6},
                interval = 0.2,
                texture = 'medium-red-slime'
            },
            ['idle-left'] = {
                frames = {7},
                texture = 'medium-red-slime'
            },
            ['idle-right'] = {
                frames = {3},
                texture = 'medium-red-slime'
            },
            ['idle-down'] = {
                frames = {1},
                texture = 'medium-red-slime'
            },
            ['idle-up'] = {
                frames = {5},
                texture = 'medium-red-slime'
            }
        }
    }
}