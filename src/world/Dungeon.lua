--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Dungeon = Class{}

function Dungeon:init(player)
    self.player = player

    -- container we could use to store rooms in a static dungeon, but unused here
    self.rooms = {}

    -- current room we're operating in
    self.currentRoom = Room(self.player)
end

--[[
    Prepares for the camera shifting process, kicking off a tween of the camera position.
]]

function Dungeon:update(dt) 
    self.currentRoom:update(dt)
end

function Dungeon:render()
    self.currentRoom:render()
end