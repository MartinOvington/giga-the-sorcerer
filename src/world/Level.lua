--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Level = Class{}

function Level:init(player)
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.tiles = {}
    self:generateWallsAndFloors()

    -- reference to player for collisions, etc.
    self.player = player

    -- entities in the level
    self.numEntitiesLeft = NUM_ENTITIES
    self.entities = {}
    self:generateEntities()

    -- game objects in the level
    self.objects = {}
    self:generateObjects()

    -- projectile objects in the level
    self.projectiles = {}

    -- used for centering the level rendering
    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y

    self.adjacentOffsetX = 0
    self.adjacentOffsetY = 0
    self.keySpawned = false
    self.timer = 0
end

--[[
    Randomly creates an assortment of enemies for the player to fight.
]]
function Level:generateEntities()
    local types = {'small-green-slime', 'small-green-slime', 'medium-green-slime'}
    for i = 1, NUM_ENTITIES do
        local type = types[math.random(#types)]
        table.insert(self.entities, Entity {
            texture = ENTITY_DEFS[type].texture,
            animations = ENTITY_DEFS[type].animations,
            walkSpeed = ENTITY_DEFS[type].walkSpeed or 20,

            -- ensure X and Y are within bounds of the map
            x = math.random(MAP_RENDER_OFFSET_X + TILE_SIZE,
                VIRTUAL_WIDTH - TILE_SIZE * 2 - 16),
            y = math.random(MAP_RENDER_OFFSET_Y + TILE_SIZE,
                VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE - 16),
            
            width = 16,
            height = 16,

            health = 1,
            player = self.player
        })

        self.entities[i].stateMachine = StateMachine {
            ['walk'] = function() return EntityWalkState(self.entities[i], self) end,
            ['idle'] = function() return EntityIdleState(self.entities[i]) end,
            ['agro'] = function() return EntityAgroState(self.entities[i]) end
        }

        self.entities[i]:changeState('walk')
    end
end

--[[
    Randomly creates an assortment of obstacles for the player to navigate around.
]]
function Level:generateObjects()
    local filledX = {}
    local filledY = {}


    for i = 1, NUMBER_OF_ROCKS do
        ::start::
        local x = MAP_RENDER_OFFSET_X + TILE_SIZE * math.random(1, self.height -2)
        local y = MAP_RENDER_OFFSET_Y + TILE_SIZE * math.random(1, self.width -2)
        for j = 1, i do
            if x == filledX[j] and y == filledY[j] or 
                math.abs(x - self.player.x) <= TILE_SIZE and math.abs(x - self.player.x) <= TILE_SIZE then
                goto start
            end
        end
        filledX[i + 1] = x
        filledY[i + 1] = y
        local rock = GameObject(
            GAME_OBJECT_DEFS['rock'], x, y   
        )
        rock.onCollide = function()
            self.player.bumped = true
        end
        table.insert(self.objects, rock)
    end
end

--[[
    Generates the walls and floors of the level, randomizing the various varieties
    of said tiles for visual variety.
]]
function Level:generateWallsAndFloors()
    for y = 1, self.height do
        table.insert(self.tiles, {})

        for x = 1, self.width do
            local id = TILE_EMPTY

            if x == 1 and y == 1 then
                id = TILE_TOP_LEFT_CORNER
            elseif x == 1 and y == self.height then
                id = TILE_BOTTOM_LEFT_CORNER
            elseif x == self.width and y == 1 then
                id = TILE_TOP_RIGHT_CORNER
            elseif x == self.width and y == self.height then
                id = TILE_BOTTOM_RIGHT_CORNER
            
            -- random left-hand walls, right walls, top, bottom, and floors
            elseif x == 1 then
                id = TILE_LEFT_WALLS[math.random(#TILE_LEFT_WALLS)]
            elseif x == self.width then
                id = TILE_RIGHT_WALLS[math.random(#TILE_RIGHT_WALLS)]
            elseif y == 1 then
                id = TILE_TOP_WALLS[math.random(#TILE_TOP_WALLS)]
            elseif y == self.height then
                id = TILE_BOTTOM_WALLS[math.random(#TILE_BOTTOM_WALLS)]
            else
                id = TILE_FLOORS[math.random(#TILE_FLOORS)]
            end
            
            table.insert(self.tiles[y], {
                id = id
            })
        end
    end
end

function Level:update(dt)
    self.timer = self.timer + dt
    -- don't update anything if we are sliding to another level (we have offsets)
    if self.adjacentOffsetX ~= 0 or self.adjacentOffsetY ~= 0 then return end

    self.player:update(dt)

    for i = #self.entities, 1, -1 do
        local entity = self.entities[i]

        -- remove entity from the table if health is <= 0
        if entity.health <= 0 then
            if entity.dead == false then
                self.numEntitiesLeft = self.numEntitiesLeft - 1
                local potion
                if self.numEntitiesLeft <= 4 and not self.keySpawned then
                    self.keySpawned = true
                    potion = GameObject(GAME_OBJECT_DEFS['key'], 
                    math.floor(entity.x), math.floor(entity.y))
                    potion.onCollide = function()
                        gStateMachine:change('win')
                    end
                elseif math.random(3) == 1 then
                    local potionNum = math.random(3)
                    if potionNum == 1 then 
                        potion = GameObject(GAME_OBJECT_DEFS['hp'], 
                        math.floor(entity.x), math.floor(entity.y))
                        potion.onCollide = function()
                            if potion.state ~= 'picked' then
                                self.player:heal()
                                potion.state = 'picked'
                                gSounds['potion']:play()
                            end
                        end
                    elseif potionNum == 2 then
                        potion = GameObject(GAME_OBJECT_DEFS['atk'], 
                        math.floor(entity.x), math.floor(entity.y))
                        potion.onCollide = function()
                            if potion.state ~= 'picked' then
                                self.player:incDmg()
                                potion.state = 'picked'
                                gSounds['potion']:play()
                            end
                        end
                    else
                        potion = GameObject(GAME_OBJECT_DEFS['spd'], 
                        math.floor(entity.x), math.floor(entity.y))
                        potion.onCollide = function()
                            if potion.state ~= 'picked' then
                                self.player:incSpd()
                                potion.state = 'picked'
                                gSounds['potion']:play()
                            end
                        end
                    end
                end
                table.insert(self.objects, potion)
            end
            entity.dead = true
        elseif not entity.dead then
            entity:processAI({level = self}, dt)
            entity:update(dt)
        end

        -- collision between the player and entities in the level
        if not entity.dead and self.player:collides(entity) and not self.player.invulnerable then
            gSounds['hit-player']:play()
            self.player:damage(1)
            self.player:goInvulnerable(1.5)

            if self.player.health == 0 then
                gStateMachine:change('game-over')
            end
        end

        for k, projectile in pairs(self.projectiles) do
            projectile:update(dt)
            if not projectile.destroyed and not entity.dead and entity:collides(projectile) then
                projectile.destroyed = true
                entity:damage(projectile.dmg)
                gSounds['hit-enemy']:play()
            end
        end
    end

    for k, object in pairs(self.objects) do
        object:update(dt)

        -- trigger collision callback on object
        if self.player:collides(object) then
            object:onCollide()
        end
    end
end

function Level:render()
    for y = 1, self.height do
        for x = 1, self.width do
            local tile = self.tiles[y][x]
            love.graphics.draw(gTextures['tiles'], gFrames['tiles'][tile.id],
                (x - 1) * TILE_SIZE + self.renderOffsetX + self.adjacentOffsetX, 
                (y - 1) * TILE_SIZE + self.renderOffsetY + self.adjacentOffsetY)
        end
    end

    for k, object in pairs(self.objects) do
        if object.type ~= 'hp' or object.state ~= 'picked' then object:render(self.adjacentOffsetX, self.adjacentOffsetY) end
    end

    for k, projectile in pairs(self.projectiles) do
        if not projectile.destroyed then projectile:render(self.adjacentOffsetX, self.adjacentOffsetY) end
    end

    for k, entity in pairs(self.entities) do
        if not entity.dead then entity:render(self.adjacentOffsetX, self.adjacentOffsetY) end
    end

    if self.player then
        self.player:render()
    end
end