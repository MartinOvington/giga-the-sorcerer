# Giga the Sorcerer - Harvard CS50 Game Development Final Project

## Overview

Giga the Sorcerer is a top-down, 2D shooting game created in Lua using the LÖVE2D framework. The aim of the game is to progress through a series of three distinctly themed levels by shooting slime enemies. When the player has slain a given number of slimes, a key spawns for them to progress to the next level. Enemies drop potions that heal or increase the stats of the player. Chests spawn in each level, which provides powerful, but limited use scrolls that can be used to clear groups of slimes. Each level has increasingly harder slimes and the player wins the game by finishing the third level. The player can then optionally choose to continue through progressively more difficult _new-game-plus_ (NG+) stages that repeat the three levels.

## Features

The game builds upon the "Legend of 50" game that was worked on in an earlier part of the course. It makes significant changes to the core gameplay and adds many features, but reuses the game structure such as the state machine, collision detection, level generation and enemy AI.

## Player

The player is the object that maintains data that must be persistent as the game progresses through levels and NG+ stages.

### Movement

The player has the ability to move in four directions using the WASD keys. Movement is restricted by the fences/walls that form a square around the level. There are obstacles in the level that also restrict movement, which add to the challenge of the game as the player must navigate around them whilst avoiding enemies. The camera follows the player around the level, keeping them at the centre of the screen. This is done by keeping camera coordinates that update with player movement and using these to apply a Love2D graphics translation before drawing the level.

### Shooting

The player shoots projectiles from their wand by using a custom cursor icon to aim. Player can shoot from both an idle state and whilst walking, then transition to the shooting version of that state. Whilst they are shooting the character faces cursor (one of four directions), which requires considering both the relative direction from the player to the mouse and whether this relative direction is dominated by the delta X or delta Y. If shooting whilst walking, the character may be facing a different to the direction of travel.

The projectile that is created from shooting requires a direction in the form of a normalised dx and dy. This is calculated by taking the vector from the player to the cursor, finding its magnitude and then dividing the vector by its magnitude to get a normalised vector. Projectiles acquire a damage amount from the player that is used to damage enemies. They have a limited range so that the player cannot slay all the enemies within the level from the starting position.

### Scrolls

The player has the ability to use consumable scrolls that they acquire from chests. The scrolls are cast using the right mouse button. They shoot out 10 projectiles in a circular pattern originating at the mouse position. The purpose of the mechanic is to make the game more interesting by giving the player another way to slay enemies. It helps to give the player the ability to deal with situations where they are swarmed with a large number of enemies, which can happen if the player walks around carelessly and puts many enemies into the _agro_ state. A special type of projectile was created for scrolls that must travel a minimum distance before damaging enemies. The purpose of this is to make sure that the projectiles are not immediately applied to a single enemy with no visual effect. In practice this technique means that even if the mouse is deliberately targeted at a single enemy, at least some of the projectiles will not hit that particular enemy. The scroll projectiles are given a different colour to the normal projectiles to visually distinguish them.

### Player Stats

The player maintains variables that represent their current speed, damage and number of scrolls that they currently hold. Speed and damage can be increased by picking up 'SPD' and 'ATK' potions and scrolls are decremented on use and incremented on opening chests.

## Enemies

Enemies are slimes that attempt to damage the player by walking into them.

### Behaviours

The base state of enemies is either idle or walking like in the Legend of 50 game. When the player comes within a constant range of an enemy, the enemy transitions to an agro state. The transition can happen when either the player walks towards to enemy or the enemy walks towards the player. Once in the agro state, the enemy stays in the agro state until it either kills the player or is itself killed. The agro state causes the enemy to walk towards the player using a combination of left/right and up/down movements depending on whether the vector towards the player is dominated by its X or Y component. It prioritises walked along the axis of the largest component of the vector. The agro state inherits from the walking state, but overrides the AI method so that the direction it walks in is towards the player rather than walking randomly. The purpose of the agro behaviour is to add a challenge to the game, as the playing area is so big that the chances of a player otherwise colliding with an enemy is low as the player has a ranged attack.

Enemies can only enter the agro state after a grace period after spawning, which is one of the things done to make sure that the player is treated fairly when they first start a level. Agro'd enemies have free-pathing through obstacles to simplify the pathing. The free-pathing looks fine as the obstacles are fairly small in size, but a more complex pathing algorithm would be necessary with bigger obstacles.

### Tiers

Enemies come in different tiers. Firstly, there are small slimes and medium slimes. Small slimes have the lowest health of the two. Medium slimes have higher health and spawn two small slimes on death. These small slimes are subject to the agro grace period mentioned above, so they do no immediately swarm the player. Each of the three levels has their own slime colour - green, blue and red. They progress in total health points and movement speed and this is mechanism of making the game more difficult as the player moves through the levels. Whenever they player enters a higher NG+ stage, enemies' health points and movement speed are increased. The increasing difficulty is necessary as the player becomes more powerful from picking up SPD and ATK potions and this keeps the game interesting.

### Drops

On death, enemies have a chance to randomly drop a HP, SPD or ATK potion. HP allows the player to heal, SPD increases their walking speed and ATK increases their attack damage from all projectiles. The system adds player progression to the game, which the player can see on the UI. Once the player has completed their mission of killing a set amount of enemies in a level, there is a guaranteed chance that a key drops that can progress them to the next level. The player has the option of picking up this key immediately or to keep killing the remaining enemies to get more potions before progressing.

## Level

The level consists on a play area that the player can move around, the boundary and the background. It manages the player, enemies, projectiles, tiles and obstacles.

### Themes

Each of the three levels has its own uniquely coloured tiered enemy and its own theme - grass, desert or castle. The theme determines the sprite that is used for the tiles of the game, which consists of three basic flat tiles, the boundary tiles and obstacle tiles. Each level has its own background that matches the theme of the level and is drawn beyond the boundary tiles.

### Level generation

The basic level generation is similar to Legend of 50, in that there is initially a central play area consisting of randomly generated flat tiles and a square boundary around these. The proportion of the flat tiles is changes slightly to have more plain tiles, as otherwise it looked cluttered. Once the basic tiles are generated, a set number of obstacles are randomly placed in the play area and these have a random chance of being a chest. Obstacles cannot spawn on the player starting location, as this causes the player to become stuck. A set number of slime enemies are then added such that they are not spawned exactly on an obstacle where they would get stuck. In order to avoid the player from getting swamped by enemies when they first enter the game, all enemies are placed outside of the agro distance of the start position of the player. The actual spawn pattern area is then a rectangle of the play area with a circular hole in the middle representing the player and their agro radius.

### Chests

Chests are collidable objects that can be interacting with by the player, when within range, by pressing the 'X' key. Chests that are within range and in the 'closed' state then give the player a scroll and transition to the 'open' state. Range is checked by creating a Hitbox around the player and checking the collision of this with the chest.

## Menu screens and UI

### Title

The first screen displayed on starting the game is the title screen, which shows the logo. From this screen the user can press 'enter' to start the game or 'c' to view the controls.

### Controls

The control screen shows which keys and mouse input correspond to which actions in the game. This was deemed necessary as things like using 'WASD' to move, 'X' to open chests and 'Right-mouse' to cast scrolls may not be immediately obvious to players. The action can start pretty quickly when first starting the level, so it useful if the player is familiar with the controls before they begin.

### Next Level

After completing a level, the next level screen is displayed, which informs that player that they completed the level and which level number they have reached. If the level that was just completed was level 3, pressing 'enter' takes them to the Win Screen, otherwise they go into the next level.

### Win

The screen displays 'You won' to inform the player that they completed the game. The player then has the option of pressing 'enter' to start a fresh game or press 'X' to start the next iteration of NG+ whilst keeping their player progress.

### UI Stats

The number of ATK and SPD potions picked up and the current number of unused scrolled are display on the UI to give a sense of progression and so that a player knows how many scrolls they have left. The UI shows the current level of NG+ if applicable.

### Status Text

Both the player and enemies maintain a set of decaying and rising status texts that float above their sprite. The status texts represent damage applied to enemies or the player, health healed by the player by picking up HP potions or ATK, SPD or scrolls picked up. As the status texts follow the enemy or player, they rises and decreases its alpha to give a sense of the order that events were applied to them. Status text gives important feedback to the player in cases where several events transpire close together, they inform them what they are getting from chests and they give them information about how much damage they are currently doing to enemies. These texts are colour coded to easily differentiate between different types of status text.

### Health Bars

All enemies and the player have a health bar that sit below their sprite. The health bar inside the rectangular outline decreases in length from right to left as the enemy or player loses health and increases when the player heals. The length of the bar represents their current health as a _proportion_ of the starting health and changes colour from green to yellow to red as the proportion decreases below certain thresholds. These health bars give the player information as to how close they are themselves to dying and how much damage they have done to individual enemies.

## Credits

The following resources were used in creation of the game:
Code - "Legend of 50" Colton Ogden
Music - "2 soundtrack" by Carnotaurus Team
Background images - "Cloudy Sky Pixel Art Infinite Background" by SavvyCow
Desert walls (modified) - "16x16 Sand Dungeon Tileset" by SavvyCow
Slime sprites (modified slightly) - "Animated Slimes 16x16 px" by Stealthix
Tiles (modified) - "Another RPG Tileset (16x16)" by fikry13
Castle tiles (modified) - "16x16 Dungeon Tileset" by 0x72
