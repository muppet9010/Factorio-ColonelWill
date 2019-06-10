local Biters = {}
local modeFilePath = "modes/chat-hunts-will-v1"
local Gui = require(modeFilePath .. "/gui.lua")
local Utils = require("utility/utils")

local function GetChunkCenterForPosition(pos)
    return {x = (math.floor(pos.x / 32) * 32) + 16, y = (math.floor(pos.y / 32) * 32) + 16}
end

function Biters.ScheduleNextAttack()
    global.nextBiterAttackTick = game.tick + math.random((15 * 60 * 60), (30 * 60 * 60))
    global.biterAttackStatus = "none"
end

function Biters.CheckBiterAttackTimer(tick)
    if tick < global.nextBiterAttackTick then
        return
    end
    local targetPos = Biters.FindWillsPosition()
    if targetPos == nil then
        --delay the attack for 5 seconds
        global.nextBiterAttackTick = global.nextBiterAttackTick + (60 * 5)
        return
    end
    Biters.StartBiterAttack(targetPos)
    Biters.ScheduleNextAttack()
    global.nextBiterAttackCount = 0
    Gui.RefreshAll()
end

function Biters.StartBiterAttack(targetPos)
    if global.nextBiterAttackCount == 0 then
        return
    end
    global.biterAttackStatus = "comming"
    local biterSpawnAreaCenter = Biters.FindNestNearPosition(targetPos)
    --global.biterAttackUnits
end

function Biters.ChunkGenerated(surface, area)
    local spawners = surface.find_entities_filtered {area = area, type = "unit-spawner", force = "enemy"}
    if #spawners == 0 then
        return
    end
    local chunkCenterPos = GetChunkCenterForPosition(area.left_top)
    local chunkCenterPosString = Utils.FormatPositionTableToString(chunkCenterPos)
    global.biterNests[chunkCenterPosString] = {count = #spawners, spawners = spawners, position = chunkCenterPos}
end

function Biters.OnEntityDied(entity)
    if entity.force.name == "enemy" and entity.type == "unit-spawner" then
        Biters.OnSpawnerDied(entity)
    end
end

function Biters.OnSpawnerDied(entity)
    local chunkCenterPos = GetChunkCenterForPosition(entity.position)
    local chunkCenterPosString = Utils.FormatPositionTableToString(chunkCenterPos)
    local nests = global.biterNests[chunkCenterPosString]
    if nests == nil then
        return
    end
    for i, spawner in pairs(nests.spawners) do
        game.print(i .. " - " .. spawner.type)
        if spawner == entity then
            nests.spawners[i] = nil
            nests.count = nests.count - 1
            if nests.count == 0 then
                global.biterNests[chunkCenterPosString] = nil
            end
            break
        end
    end
end

function Biters.FindWillsPosition()
    local player = game.get_player("ColonelWill")
    if player == nil then
        return nil
    end
    local character = player.character
    if character == nil then
        return nil
    end
    local pos = character.position
    return pos
end

function Biters.FindNestNearPosition(pos)
    -- TODO
end

return Biters
