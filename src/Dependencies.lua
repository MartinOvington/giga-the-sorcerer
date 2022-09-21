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

require 'src/world/Dungeon'
require 'src/world/Room'

require 'src/states/BaseState'

require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'

require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerWalkState'
require 'src/states/entity/player/PlayerShootIdleState'


require 'src/states/game/GameOverState'
require 'src/states/game/PlayState'
require 'src/states/game/StartState'

gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/tiles.png'),
    ['background'] = love.graphics.newImage('graphics/background.jpg'),
    ['hearts'] = love.graphics.newImage('graphics/hearts.png'),
    ['entities'] = love.graphics.newImage('graphics/entities.png'),
    ['projectile'] = love.graphics.newImage('graphics/projectile.png')
}

gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], 16, 16),
    ['entities'] = GenerateQuads(gTextures['entities'], 16, 16),
    ['hearts'] = GenerateQuads(gTextures['hearts'], 16, 16),
    ['projectile'] = GenerateQuads(gTextures['projectile'], 16, 16)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['gothic-medium'] = love.graphics.newFont('fonts/GothicPixels.ttf', 16),
    ['gothic-large'] = love.graphics.newFont('fonts/GothicPixels.ttf', 32),
    ['freedom'] = love.graphics.newFont('fonts/Freedom-nZ4J.otf', 48),
    ['freedom-small'] = love.graphics.newFont('fonts/Freedom-nZ4J.otf', 24)
}

gSounds = {
    ['intro-music'] = love.audio.newSource('sounds/intro-music.ogg', 'static'),
    ['hit-enemy'] = love.audio.newSource('sounds/hit_enemy.wav', 'static'),
    ['hit-player'] = love.audio.newSource('sounds/hit_player.wav', 'static'),
    ['heart'] = love.audio.newSource('sounds/heart.wav', 'static'),
    ['player-shoot'] = love.audio.newSource('sounds/player_shoot.wav', 'static'),
}