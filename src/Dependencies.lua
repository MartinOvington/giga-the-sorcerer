--
-- libraries
--

Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Animation'
require 'src/constants'
require 'src/Entity'
require 'src/entity_defs'
require 'src/GameObject'
require 'src/Projectile'
require 'src/game_objects'
require 'src/Hitbox'
require 'src/Wand'
require 'src/Player'
require 'src/StateMachine'
require 'src/Util'

require 'src/world/Level'

require 'src/states/BaseState'

require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/EntityAgroState'

require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerWalkState'
require 'src/states/entity/player/PlayerShootIdleState'
require 'src/states/entity/player/PlayerShootWalkState'


require 'src/states/game/GameOverState'
require 'src/states/game/PlayState'
require 'src/states/game/StartState'
require 'src/states/game/WinState'

gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/tiles.png'),
    ['small-green-slime'] = love.graphics.newImage('graphics/Slime_Small_Green.png'),
    ['medium-green-slime'] = love.graphics.newImage('graphics/Slime_Medium_Green.png'),
    ['background'] = love.graphics.newImage('graphics/background.png'),
    ['menu-background'] = love.graphics.newImage('graphics/menu-background.jpg'),
    ['drops'] = love.graphics.newImage('graphics/drops.png'),
    ['entities'] = love.graphics.newImage('graphics/entities.png'),
    ['projectile'] = love.graphics.newImage('graphics/projectile.png')
}

gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
    ['small-green-slime'] = GenerateQuads(gTextures['small-green-slime'], 16, 16),
    ['medium-green-slime'] = GenerateQuads(gTextures['medium-green-slime'], 16, 16),
    ['entities'] = GenerateQuads(gTextures['entities'], 16, 16),
    ['drops'] = GenerateQuads(gTextures['drops'], 16, 16),
    ['projectile'] = GenerateQuads(gTextures['projectile'], 16, 16)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['gothic-medium'] = love.graphics.newFont('fonts/GothicPixels.ttf', 16),
    ['gothic-large'] = love.graphics.newFont('fonts/GothicPixels.ttf', 32),
    ['freedom'] = love.graphics.newFont('fonts/FutilePro.ttf', 40),
    ['freedom-small'] = love.graphics.newFont('fonts/FutilePro.ttf', 20)
}

gSounds = {
    ['intro-music'] = love.audio.newSource('sounds/intro-music.ogg', 'static'),
    ['hit-enemy'] = love.audio.newSource('sounds/hit_enemy.wav', 'static'),
    ['hit-player'] = love.audio.newSource('sounds/hit_player.wav', 'static'),
    ['potion'] = love.audio.newSource('sounds/potion.wav', 'static'),
    ['player-shoot'] = love.audio.newSource('sounds/player_shoot.wav', 'static'),
}