# Giga the Sorcerer - Harvard CS50 Project

## Overview

Giga the Sorcerer is a top-down, 2D shooting game. The aim of the game is to progress through a series of three distinctly themed levels by shooting slime enemies. When the player has slain a given number of slimes, a key spawns for them to progress to the next level. Enemies drop potions that heal or increase the stats of the player. Chests spawn in each level, which provides powerful, but limited use scrolls that can be used to clear groups of slimes. Each level has increasingly harder slimes and the player wins the game by finishing the third level. The player can then optionally choose to continue through progressively more difficult _new-game-plus_ (NG+) stages that repeat the three levels.

## Features

The game builds upon CS50's Zelda game that was worked on in an earlier part of the course. It makes significant changes to the core gameplay and adds many features, but reuses the game structure such as the state machine, collision detection, level generation and mob AI.

## Player

The player is the object that maintains data that must be persistent as the game progresses through levels and NG+ stages.

### Movement

The player has the ability to move in four directions using the WASD keys. Movement is restricted by the fences/walls that form a square around the level. There are obstacles in the level that also restrict movement, which add to the challenge of the game as the player must navigate around them whilst avoiding enemies. The camera follows the player around the level, keeping them at the centre of the screen. This is done by keeping camera coordinates that update with player movement and using these to apply a Love2D graphics translation before drawing the level.

### Shooting

The player shoots projectiles from their wand by using a custom cursor icon to aim. Player can shoot from both an idle state and whilst walking, then transition to the shooting version of that state. Whilst they are shooting the character faces cursor (one of four directions), which requires considering both the relative direction from the player to the mouse and whether this relative direction is dominated by the delta X or delta Y. If shooting whilst walking, the character may be facing a different to the direction of travel.

The projectile that is created from shooting requires a direction in the form of a normalised dx and dy. This is calculated by taking the vector from the player to the cursor, finding its magnitude and then dividing the vector by its magnitude to get a normalised vector. Projectiles acquire a damage amount from the player that is used to damage enemies. They have a limited range so that the player cannot slay all the enemies within the level from the starting position.

### Scrolls

The player has the ability to use consumable scrolls that they acquire from chests. The scrolls are cast using the right mouse button. They shoot out 10 projectiles in a circular pattern originating at the mouse position. The purpose of the mechanic is to make the game more interesting by giving the player another way to slay enemies. It helps to give the player the ability to deal with situations where they are swarmed with a large number of enemies, which can happen if the player walks around carelessly and puts many enemies into the _agro_ state.

### Player Stats

The player maintains variables that represent their current speed, damage and number of scrolls that they currently hold. Speed and damage can be increased by picking up 'SPD' and 'ATK' potions and scrolls are decremented on use and incremented on opening chests. These statistics are display on the UI to give a sense of progression and so that a player knows how many scrolls they have left. The player object also has the level number and NG+ number, which is used to generate the levels and show the level number on the screen in between levels.
