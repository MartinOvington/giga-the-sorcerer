
Level = Class{}

function Level:init(player)
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.tiles = {}
    self:generateWallsAndFloors()

    -- reference to player for collisions, etc.
    self.player = player

    -- entities in the level
    self.entityTypes = {}
    if self.player.levelNum == 1 then
        self.entityTypes = {'small-green-slime', 'small-green-slime', 'medium-green-slime'}
    elseif self.player.levelNum == 2 then
        self.entityTypes = {'small-blue-slime', 'small-blue-slime', 'medium-blue-slime'}
    else
        self.entityTypes = {'small-red-slime', 'small-red-slime', 'medium-red-slime'}
    end
    self.tileTexture = 'grass-tiles'
    self.objectType = 'bush'
    self.chestType = 'grass-chest'
    if player.levelNum == 2 then
        self.tileTexture = 'desert-tiles'
        self.objectType = 'rock'
        self.chestType = 'desert-chest'
    elseif player.levelNum == 3 then
        self.tileTexture = 'castle-tiles'
        self.objectType = 'gravestone'
        self.chestType = 'castle-chest'
    end

    -- game objects in the level
    self.filledX = {}
    self.filledY = {}
    self.objects = {}
    self:generateObjects()

    self.numEntitiesKilled = 0
    self.entities = {}
    self:generateEntities()

    -- projectile objects in the level
    self.projectiles = {}

    -- used for centering the level rendering
    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y

    self.adjacentOffsetX = 0
    self.adjacentOffsetY = 0
    self.keySpawned = false
end



function Level:distToPlayer(x, y)
    return math.sqrt((x - self.player.x) * (x - self.player.x) + (y - self.player.y) * (y - self.player.y))
end

--[[
    Randomly creates an assortment of enemies for the player to fight.
]]
function Level:generateEntities()

    for i = 1, NUM_ENTITIES do
        local type = self.entityTypes[math.random(#self.entityTypes)]
        local entityX = -1
        local entityY = -1
        local overlapped = false
        repeat
            ::start::
            entityX = math.random(MAP_RENDER_OFFSET_X + TILE_SIZE,
                VIRTUAL_WIDTH - TILE_SIZE * 2 - 16)
            entityY = math.random(MAP_RENDER_OFFSET_Y + TILE_SIZE,
                VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE - 16)
            for j = 1, #self.filledX do
                if entityX == self.filledX[j] and entityY == self.filledY[j] then
                        goto start
                    end
                end
        until (self:distToPlayer(entityX, entityY) >= AGRO_RANGE + TILE_SIZE)
        
        table.insert(self.entities, Entity {
            texture = ENTITY_DEFS[type].texture,
            animations = ENTITY_DEFS[type].animations,
            walkSpeed = ENTITY_DEFS[type].walkSpeed + (self.player.newGameNum - 1) * 5,
            slimeSize = ENTITY_DEFS[type].slimeSize,
            x = entityX,
            y = entityY,
            width = 16,
            height = 16,

            health = ENTITY_DEFS[type].health * self.player.newGameNum or 1,
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
    for i = 1, NUMBER_OF_OBSTACLES do
        ::start::
        local x = MAP_RENDER_OFFSET_X + TILE_SIZE * math.random(1, self.height -2)
        local y = MAP_RENDER_OFFSET_Y + TILE_SIZE * math.random(1, self.width -2)
        for j = 1, i do
            if x == self.filledX[j] and y == self.filledY[j] or 
                math.abs(x - self.player.x) <= TILE_SIZE and math.abs(x - self.player.x) <= TILE_SIZE then
                goto start
            end
        end
        self.filledX[i + 1] = x
        self.filledY[i + 1] = y
        local obstacle
        if math.random(CHEST_FREQUENCY) < CHEST_FREQUENCY then
            obstacle = GameObject(
                GAME_OBJECT_DEFS[self.objectType], x, y   
            )
            obstacle.onCollide = function()
                self.player.bumped = true
            end
        else
            obstacle = GameObject(
                GAME_OBJECT_DEFS[self.chestType], x, y   
            )
            obstacle.onCollide = function()
                self.player.bumped = true
            end
        end
        table.insert(self.objects, obstacle)
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
                local tmp = math.random(5)
                if tmp < 4 then
                    tmp = 1
                elseif tmp == 4 then
                    tmp = 2
                else 
                    tmp = 3
                end
                id = TILE_FLOORS[tmp]
            end
            
            table.insert(self.tiles[y], {
                id = id
            })
        end
    end
end

function Level:createDrop(entity)
    local potion
    if self.numEntitiesKilled >= WIN_CONDITION and not self.keySpawned then
        self.keySpawned = true
        potion = GameObject(GAME_OBJECT_DEFS['key'], 
        math.floor(entity.x), math.floor(entity.y))
        potion.onCollide = function()
            gStateMachine:change('next-level', {player = self.player})
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
                    gSounds['potion']:stop()
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
                    gSounds['potion']:stop()
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
                    gSounds['potion']:stop()
                    gSounds['potion']:play()
                end
            end
        end
    end
    table.insert(self.objects, potion)
end

function Level:update(dt)
    -- don't update anything if we are sliding to another level (we have offsets)
    if self.adjacentOffsetX ~= 0 or self.adjacentOffsetY ~= 0 then return end

    self.player:update(dt)
    local entitiesToAdd = {}
    for i = #self.entities, 1, -1 do
        local entity = self.entities[i]

        if entity.health <= 0 then
            if entity.dead == false then
                if entity.slimeSize == 'medium' then
                    gSounds['slime-split']:play()
                    for i = 1, 2, 1 do
                        local newEntity = Entity {
                            texture = ENTITY_DEFS[self.entityTypes[1]].texture,
                            animations = ENTITY_DEFS[self.entityTypes[1]].animations,
                            walkSpeed = ENTITY_DEFS[self.entityTypes[1]].walkSpeed + (self.player.newGameNum - 1) * 5,
                            slimeSize = ENTITY_DEFS[self.entityTypes[1]].slimeSize,
                            x = entity.x -5 + 10 * i,
                            y = entity.y,
                            width = 16,
                            height = 16,
                
                            health = ENTITY_DEFS[self.entityTypes[1]].health * self.player.newGameNum or 1,
                            player = self.player
                        }
                        newEntity.stateMachine = StateMachine {
                            ['walk'] = function() return EntityWalkState(newEntity, self) end,
                            ['idle'] = function() return EntityIdleState(newEntity) end,
                            ['agro'] = function() return EntityAgroState(newEntity) end
                        }
                        newEntity:changeState('walk')
                        table.insert(entitiesToAdd, newEntity)
                    end
                end
                self.numEntitiesKilled = self.numEntitiesKilled + 1
                self:createDrop(entity)
            entity.dead = true
            end
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
    end

    for i = 1, #entitiesToAdd, 1 do
        table.insert(self.entities, entitiesToAdd[i])
    end

    for k, projectile in pairs(self.projectiles) do
        projectile:update(dt)
        for i = #self.entities, 1, -1 do
            local entity = self.entities[i]
            if not projectile.destroyed and not entity.dead and entity:collides(projectile) then
                if projectile.type ~= 'shot-scroll' or projectile.distTravelled > SCROLL_TRAVEL_TIL_DESTROY then
                    projectile.destroyed = true
                    entity:damage(projectile.dmg)
                    gSounds['hit-enemy']:play()
                end
            end
        end
    end

    for k, object in pairs(self.objects) do
        object:update(dt)

        if self.player:collides(object) then
            object:onCollide()
        end
    end
end

function Level:render()
    for y = 1, self.height do
        for x = 1, self.width do
            local tile = self.tiles[y][x]
            love.graphics.draw(gTextures[self.tileTexture], gFrames[self.tileTexture][tile.id],
                (x - 1) * TILE_SIZE + self.renderOffsetX + self.adjacentOffsetX, 
                (y - 1) * TILE_SIZE + self.renderOffsetY + self.adjacentOffsetY)
        end
    end

    for k, object in pairs(self.objects) do
        if object.state ~= 'picked' then object:render(self.adjacentOffsetX, self.adjacentOffsetY) end
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