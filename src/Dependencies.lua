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
require 'src/StatusText'

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
require 'src/states/game/NextLevelState'

gTextures = {
    ['grass-tiles'] = love.graphics.newImage('graphics/grass-tiles.png'),
    ['desert-tiles'] = love.graphics.newImage('graphics/desert-tiles.png'),
    ['castle-tiles'] = love.graphics.newImage('graphics/castle-tiles.png'),
    ['small-green-slime'] = love.graphics.newImage('graphics/Slime_Small_Green.png'),
    ['medium-green-slime'] = love.graphics.newImage('graphics/Slime_Medium_Green.png'),
    ['small-blue-slime'] = love.graphics.newImage('graphics/Slime_Small_Blue.png'),
    ['medium-blue-slime'] = love.graphics.newImage('graphics/Slime_Medium_Blue.png'),
    ['small-red-slime'] = love.graphics.newImage('graphics/Slime_Small_Red.png'),
    ['medium-red-slime'] = love.graphics.newImage('graphics/Slime_Medium_Red.png'),
    ['background-grass'] = love.graphics.newImage('graphics/background-grass.png'),
    ['background-desert'] = love.graphics.newImage('graphics/background-desert.png'),
    ['background-castle'] = love.graphics.newImage('graphics/background-castle.png'),
    ['menu-background'] = love.graphics.newImage('graphics/menu-background.jpg'),
    ['drops'] = love.graphics.newImage('graphics/drops.png'),
    ['entities'] = love.graphics.newImage('graphics/entities.png'),
    ['projectile'] = love.graphics.newImage('graphics/projectile.png')
}

gFrames = {
    ['grass-tiles'] = GenerateQuads(gTextures['grass-tiles'], 16, 16),
    ['desert-tiles'] = GenerateQuads(gTextures['desert-tiles'], 16, 16),
    ['castle-tiles'] = GenerateQuads(gTextures['castle-tiles'], 16, 16),
    ['small-green-slime'] = GenerateQuads(gTextures['small-green-slime'], 16, 16),
    ['medium-green-slime'] = GenerateQuads(gTextures['medium-green-slime'], 16, 16),
    ['small-blue-slime'] = GenerateQuads(gTextures['small-blue-slime'], 16, 16),
    ['medium-blue-slime'] = GenerateQuads(gTextures['medium-blue-slime'], 16, 16),
    ['small-red-slime'] = GenerateQuads(gTextures['small-red-slime'], 16, 16),
    ['medium-red-slime'] = GenerateQuads(gTextures['medium-red-slime'], 16, 16),
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
    ['freedom-small'] = love.graphics.newFont('fonts/FutilePro.ttf', 16),
    ['freedom-status'] = love.graphics.newFont('fonts/FutilePro.ttf', 12)
}

gSounds = {
    ['intro-music'] = love.audio.newSource('sounds/intro-music.mp3', 'static'),
    ['hit-enemy'] = love.audio.newSource('sounds/hit_enemy.wav', 'static'),
    ['hit-player'] = love.audio.newSource('sounds/hit_player.wav', 'static'),
    ['potion'] = love.audio.newSource('sounds/potion.wav', 'static'),
    ['player-shoot'] = love.audio.newSource('sounds/player_shoot.wav', 'static'),
    ['slime-split'] = love.audio.newSource('sounds/slime_split.wav', 'static'),
    ['open-chest'] = love.audio.newSource('sounds/open_chest.wav', 'static'),
    ['scroll'] = love.audio.newSource('sounds/scroll.wav', 'static')
}

gColors = {
    ['white'] = { 1, 1, 1, 1 },
    ['red'] = { 1, 0, 0, 1 },
    ['pink'] = { 1, 0, 1, 1 },
    ['green-spd'] = { 0, 1, 9/255, 1 },
    ['green-hp'] = { 0.1, 0.8, 0, 1 },
    ['orange'] = { 1, 165/255, 0, 1 }
}

gSounds['hit-enemy']:setVolume(0.4)
gSounds['intro-music']:setVolume(0.3)