local Biters = {}
local Utils = require("utility/utils")
local Commands = require("utility/commands")
local Logging = require("utility/logging")

local targetPlayerName = "ColonelWill"
local attackTimeRangeMinutes = {15, 30}
local biterStatusMessageViewTime = 15 * 60

local debugLogging = true
local debugMode = true
if debugMode then
    targetPlayerName = "muppet9010"
    attackTimeRangeMinutes = {1, 1}
end

local function GetChunkCenterForPosition(pos)
    return {x = (math.floor(pos.x / 32) * 32) + 16, y = (math.floor(pos.y / 32) * 32) + 16}
end

function Biters.ScheduleNextAttack(shortTime)
    if debugMode then
        game.print("TEST MODE ENABLED")
    end
    local delay
    if shortTime then
        delay = 1 * 60 * 60
    else
        delay = math.random((attackTimeRangeMinutes[1] * 60 * 60), (attackTimeRangeMinutes[2] * 60 * 60))
    end
    global.nextBiterAttackTick = game.tick + delay
    global.biterCurrentAttackChunkPathTested = {}
    global.biterCurrentAttackChunkPosition = nil
    global.biterCurrentAttackChunkPathTestWaiting = false
end

function Biters.CheckBiterAttackTimer(tick)
    if tick < global.nextBiterAttackTick then
        return
    end
    Logging.LogPrint("timer up", debugLogging)
    if global.nextBiterAttackCount == 0 then
        Biters.ScheduleNextAttack()
        return
    end
    if global.biterCurrentAttackChunkPathTestWaiting then
        --delay the attack for 1 seconds
        global.nextBiterAttackTick = global.nextBiterAttackTick + (60 * 1)
        Logging.LogPrint("waiting for path", debugLogging)
        return
    end
    local targetPos = Biters.FindWillsPosition()
    if targetPos == nil then
        --delay the attack for 5 seconds
        global.nextBiterAttackTick = global.nextBiterAttackTick + (60 * 5)
        Logging.LogPrint("no target to Will found", debugLogging)
        return
    end
    if global.biterCurrentAttackChunkPosition == nil then
        Logging.LogPrint("finding a nest to do a path test to", debugLogging)
        Biters.StartPathTestToNextSuitableNestNearPosition(targetPos)
        return
    end
    Biters.TidyUpAnyOldAttackGroup()
    Biters.StartBiterAttack(global.biterCurrentAttackChunkPosition)
    Biters.ScheduleNextAttack()
end

function Biters.MonitorStatus()
    if global.biterAttackStatus == "none" then
        return
    end
    if game.tick > global.biterStatusUpdateTick and global.biterAttackStatus ~= "comming" then
        global.biterAttackStatus = "none"
        return
    end
    if global.biterCurrentAttackCurrentSize == 0 and global.biterAttackStatus == "comming" then
        global.biterAttackStatus = "will-won"
        global.biterStatusUpdateTick = game.tick + biterStatusMessageViewTime
        return
    end
    if global.biterCurrentAttackUnitGroup == nil or not global.biterCurrentAttackUnitGroup.valid then
        Biters.AddCurrentBitersToCurrentUnitGroup()
    end
    if global.biterCurrentAttackUnitGroup == nil then
        return
    end
    local biterGroupState = global.biterCurrentAttackUnitGroup.state
    if biterGroupState == defines.group_state.gathering or biterGroupState == defines.group_state.finished then
        Biters.MakeBiterGroupTargetPlayer()
    end
end

function Biters.TidyUpAnyOldAttackGroup()
    if global.biterCurrentAttackUnitGroup == nil or not global.biterCurrentAttackUnitGroup.valid then
        Biters.AddCurrentBitersToCurrentUnitGroup()
    end
    if global.biterCurrentAttackUnitGroup == nil then
        return
    end
    Biters.MakeBiterGroupTargetSpawn()
    global.biterCurrentAttackUnitGroup = nil
    global.biterCurrentAttackUnits = {}
end

function Biters.StartBiterAttack(targetPos)
    Logging.LogPrint("starting biter attack at pos: " .. Logging.PositionToString(targetPos), debugLogging)
    global.biterAttackStatus = "comming"

    local surface = global.biterCurrentAttackSurface
    local evolution = game.forces["enemy"].evolution_factor + 0.1
    local spawnerTypes = {"biter-spawner", "spitter-spawner"}
    for i = 1, global.nextBiterAttackCount do
        local spawnerType = spawnerTypes[math.random(2)]
        local biterType = Utils.GetBiterType(global.modEnemyProbabilities, spawnerType, evolution)
        local unitPos = surface.find_non_colliding_position(biterType, targetPos, 0, 1)
        local biter = surface.create_entity {name = biterType, position = unitPos, force = game.forces["enemy"]}
        if not biter then
            game.print("creation of biter" .. i .. "failed")
        else
            table.insert(global.biterCurrentAttackUnits, biter)
        end
    end
    global.biterCurrentAttackStartingSize = #global.biterCurrentAttackUnits
    global.biterCurrentAttackCurrentSize = #global.biterCurrentAttackUnits
    global.nextBiterAttackCount = 0
end

function Biters.AddCurrentBitersToCurrentUnitGroup()
    local aliveBiter
    for _, biter in pairs(global.biterCurrentAttackUnits) do
        if biter.valid then
            aliveBiter = biter
        end
    end
    if aliveBiter == nil then
        global.biterCurrentAttackUnitGroup = nil
        return
    end
    global.biterCurrentAttackUnitGroup = aliveBiter.surface.create_unit_group {position = aliveBiter.position, force = game.forces["enemy"]}
    for _, biter in pairs(global.biterCurrentAttackUnits) do
        global.biterCurrentAttackUnitGroup.add_member(biter)
    end
end

function Biters.MakeBiterGroupTargetPlayer()
    local targetEntity = Biters.FindWillsCharacter()
    if targetEntity == nil then
        return
    end
    local attackCommand = {type = defines.command.attack, target = targetEntity}
    global.biterCurrentAttackUnitGroup.set_command(attackCommand)
end

function Biters.MakeBiterGroupTargetSpawn()
    local attackCommand = {type = defines.command.attack_area, destination = {0, 0}, radius = 100}
    global.biterCurrentAttackUnitGroup.set_command(attackCommand)
end

function Biters.ChunkGenerated(surface, area)
    local spawners = surface.find_entities_filtered {area = area, type = "unit-spawner", force = "enemy"}
    if #spawners == 0 then
        return
    end
    local validSpawners = {}
    for i, spawner in pairs(spawners) do
        if Utils.IsPositionInBoundingBox(spawner.position, area, true) then
            table.insert(validSpawners, spawner)
        end
    end
    if #validSpawners == 0 then
        return
    end
    local chunkCenterPos = GetChunkCenterForPosition(area.left_top)
    local chunkCenterPosString = Utils.FormatPositionTableToString(chunkCenterPos)
    global.biterNests[chunkCenterPosString] = {count = #validSpawners, spawners = validSpawners, position = chunkCenterPos}
end

function Biters.OnEntityDied(entity)
    if entity.force.name == "enemy" and entity.type == "unit-spawner" then
        Biters.OnSpawnerDied(entity)
    elseif entity.force.name == "enemy" and entity.type == "unit" then
        Biters.OnBiterDied(entity)
    end
end

function Biters.OnSpawnerDied(entity)
    local chunkCenterPos = GetChunkCenterForPosition(entity.position)
    local chunkCenterPosString = Utils.FormatPositionTableToString(chunkCenterPos)
    local nests = global.biterNests[chunkCenterPosString]
    if nests == nil then
        game.print("killed nest not found in list - something is wrong!")
        return
    end
    for i, spawner in pairs(nests.spawners) do
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

function Biters.OnBiterDied(entity)
    for i, biter in pairs(global.biterCurrentAttackUnits) do
        if (not biter.valid) or (entity == biter) then
            global.biterCurrentAttackUnits[i] = nil
            global.biterCurrentAttackCurrentSize = global.biterCurrentAttackCurrentSize - 1
        end
    end
end

function Biters.OnPlayerDied(event)
    if global.biterAttackStatus ~= "comming" then
        return
    end
    local player = game.get_player(event.player_index)
    if string.lower(player.name) ~= string.lower(targetPlayerName) then
        return
    end
    local causeEntity = event.cause
    if causeEntity.force.name ~= "enemy" or causeEntity.type ~= "unit" then
        return
    end
    for _, biter in pairs(global.biterCurrentAttackUnits) do
        if biter.valid and biter == causeEntity then
            global.biterAttackStatus = "will-lost"
            global.biterStatusUpdateTick = game.tick + biterStatusMessageViewTime
            global.gameFinished = true
            game.set_game_state {game_finished = true, player_won = false, can_continue = false, victorious_force = game.forces["enemy"]}
            return
        end
    end
end

function Biters.OnBaseBuilt(entity)
    if entity.type ~= "unit-spawner" then
        return
    end
    local chunkCenterPos = GetChunkCenterForPosition(entity.position)
    local chunkCenterPosString = Utils.FormatPositionTableToString(chunkCenterPos)
    if global.biterNests[chunkCenterPosString] == nil then
        global.biterNests[chunkCenterPosString] = {count = 1, spawners = {entity}, position = chunkCenterPos}
    else
        local nests = global.biterNests[chunkCenterPosString]
        for _, spawner in pairs(nests.spawners) do
            if spawner == entity then
                return
            end
        end
        table.insert(nests.spawners, entity)
        nests.count = nests.count + 1
    end
end

function Biters.FindWillsCharacter()
    local player = game.get_player(targetPlayerName)
    if player == nil then
        return nil
    end
    return player.character
end
function Biters.FindWillsPosition()
    local playerCharacter = Biters.FindWillsCharacter()
    if playerCharacter == nil then
        return nil
    end
    local pos = playerCharacter.position
    global.biterCurrentAttackSurface = playerCharacter.surface
    Logging.LogPrint("player target pos: " .. Logging.PositionToString(pos), debugLogging)
    return pos
end

function Biters.StartPathTestToNextSuitableNestNearPosition(targetPos)
    local spawnerChunkDistances = {}
    for key, nests in pairs(global.biterNests) do
        local alreadyChecked = false
        for _, testedChunkCentrePos in pairs(global.biterCurrentAttackChunkPathTested) do
            if testedChunkCentrePos.x == nests.position.x and testedChunkCentrePos.y == nests.position.y then
                alreadyChecked = true
            end
        end
        if not alreadyChecked then
            local distance = Utils.RoundNumberToDecimalPlaces(Utils.GetDistance(targetPos, nests.position), 0)
            if spawnerChunkDistances[distance] == nil then
                spawnerChunkDistances[distance] = {nests}
            else
                table.insert(spawnerChunkDistances[distance], nests)
            end
        end
    end

    local playerPositions = {}
    for _, player in pairs(game.connected_players) do
        if player.character ~= nil then
            table.insert(playerPositions, player.character.position)
        end
    end

    for _, nestsList in pairs(spawnerChunkDistances) do
        local chunkCenterPos = nestsList[1].position
        local playerTooClose = false
        for _, playerPos in pairs(playerPositions) do
            if Utils.GetDistance(chunkCenterPos, playerPos) < 100 then
                playerTooClose = true
                break
            end
        end
        if not playerTooClose then
            local pathId =
                global.biterCurrentAttackSurface.request_path {
                bounding_box = {left_top = {-1, -1}, right_bottom = {1, 1}},
                collision_mask = game.entity_prototypes["small-biter"].collision_mask,
                start = chunkCenterPos,
                goal = targetPos,
                force = "enemy"
            }
            global.biterCurrentAttackChunkPathTested[pathId] = chunkCenterPos
            global.biterCurrentAttackChunkPathTestWaiting = true
            return
        end
    end

    game.print("No biter spawners that can reach ColonelWill on map, so no biters can come. Will retry soon.")
    Biters.ScheduleNextAttack(true)
end

function Biters.OnScriptPathRequestFinished(event)
    local chunkPosition = global.biterCurrentAttackChunkPathTested[event.id]
    if chunkPosition == nil then
        return
    end
    global.biterCurrentAttackChunkPathTestWaiting = false
    if event.path == nil then
        return
    end
    global.biterCurrentAttackChunkPosition = chunkPosition
end

function Biters.AddCommands()
    Commands.Register("add-biters", {"api-description.colonelwill-chat-hunts-will-v1-add-biters-command"}, Biters.AddBitersCommandHandle, true)
    Commands.Register("attack-now", {"api-description.colonelwill-chat-hunts-will-v1-attack-now-command"}, Biters.AttackNowCommandHandle, true)
    Commands.Register("rescan-nests", "rescan biter nests to fix old mod version", Biters.ReScanBiterNests, true)
end

function Biters.AddBitersCommandHandle(command)
    local args = Commands.GetArgumentsFromCommand(command.parameter)
    local value = tonumber(args[1])
    local supporterName = args[2]
    if value == nil then
        game.print("invalid add_biters value: " .. command.parameter)
        return
    end
    global.nextBiterAttackCount = global.nextBiterAttackCount + value
    if supporterName ~= nil then
        game.print(supporterName .. " sent " .. tostring(value) .. " biters to the horde")
    else
        game.print("added " .. tostring(value) .. " biters to the horde")
    end
    if global.nextBiterAttackCount >= 200 then
        Biters.AttackNow()
    end
end

function Biters.AttackNowCommandHandle()
    Biters.AttackNow()
    game.print("chat hoarde triggered to attack now")
end

function Biters.AttackNow()
    global.nextBiterAttackTick = game.tick
end

function Biters.ReScanBiterNests()
    global.biterNests = {}
    local surface = game.surfaces[1]
    for chunk in surface.get_chunks() do
        local area = {left_top = {x = (chunk.x * 32), y = (chunk.y * 32)}, right_bottom = {x = (chunk.x * 32) + 31, y = (chunk.y * 32) + 31}}
        Biters.ChunkGenerated(surface, area)
    end
end

return Biters
