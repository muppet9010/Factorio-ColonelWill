local modeFilePath = "modes/chat-hunts-will-v1"
local Utils = require("utility/utils")
local GuiUtil = require("utility/gui-util")
local Gui = require(modeFilePath .. "/gui.lua")
--local Logging = require("utility/logging")
local Biters = require(modeFilePath .. "/biters.lua")

if settings.startup["colonelwill_mode"].value ~= "chat-hunts-will-v1" then
    return
end

local function OnRocketLaunched(event)
    local rocket = event.rocket
    if rocket == nil or not rocket.valid then
        return
    end
    for name, count in pairs(rocket.get_inventory(defines.inventory.rocket).get_contents()) do
        if name == "colonelwill-chat-hunts-will-v1-escape-pod" and count > 0 and not global.gameFinished then
            global.gameFinished = true
            game.set_game_state {game_finished = true, player_won = true, can_continue = true, victorious_force = rocket.force}
        end
    end
end

local function OnResearchFinished(event)
    local technology = event.research
    if string.find(technology.name, "colonelwill-chat-hunts-will-v1-recruit-workforce-member", 0, true) then
        global.recruitedWorkforceCount = technology.level
        Gui.RefreshAll()
    end
end

local function OnPlayerJoinedGame(event)
    local player = game.get_player(event.player_index)
    Gui.GuiRecreate(player)
end

local function CreateGlobals()
    global.gameFinished = global.gameFinished or false
    global.recruitedWorkforceCount = global.recruitedWorkforceCount or 0
    global.nextBiterAttackCount = global.nextBiterAttackCount or 0
    global.biterAttackStatus = global.biterAttackStatus or "none"
    global.biterNests = global.biterNests or {}
    global.biterCurrentAttackUnits = global.biterCurrentAttackUnits or {}
    global.biterCurrentAttackUnitGroup = global.biterCurrentAttackUnitGroup or nil
    global.biterCurrentAttackStartingSize = global.biterCurrentAttackStartingSize or 0
    global.biterCurrentAttackCurrentSize = global.biterCurrentAttackCurrentSize or 0
    global.biterCurrentAttackChunkPathTested = global.biterCurrentAttackChunkPathTested or {}
    global.biterCurrentAttackChunkPathTestWaiting = global.biterCurrentAttackChunkPathTestWaiting or false
    global.biterCurrentAttackChunkPosition = global.biterCurrentAttackChunkPosition or nil
    global.biterCurrentAttackSurface = global.biterCurrentAttackSurface or nil
    global.biterStatusUpdateTick = global.biterStatusUpdateTick or 0
    if global.nextBiterAttackTick == nil then
        global.nextBiterAttackTick = 0
        Biters.ScheduleNextAttack()
    end
    GuiUtil.CreateAllPlayersElementReferenceStorage()
end

local function OnLoad()
    Biters.AddCommands()
    Utils.DisableSiloScript()
end

local function OnStartup()
    Utils.DisableIntroMessage()
    CreateGlobals()
    OnLoad()
    Gui.GuiRecreateAll()
end

local function On60Ticks(event)
    Biters.CheckBiterAttackTimer(event.tick)
    Biters.MonitorStatus()
    Gui.RefreshAll()
end

local function OnChunkGenerated(event)
    Biters.ChunkGenerated(event.surface, event.area)
end

local function OnEntityDied(event)
    Biters.OnEntityDied(event.entity)
end

local function OnBiterBaseBuilt(event)
    Biters.OnBaseBuilt(event.entity)
end

local function OnScriptPathRequestFinished(event)
    Biters.OnScriptPathRequestFinished(event)
end

local function OnPlayerDied(event)
    Biters.OnPlayerDied(event)
end

script.on_init(OnStartup)
script.on_load(OnLoad)
script.on_configuration_changed(OnStartup)
script.on_event(defines.events.on_rocket_launched, OnRocketLaunched)
script.on_event(defines.events.on_research_finished, OnResearchFinished)
script.on_event(defines.events.on_player_joined_game, OnPlayerJoinedGame)
script.on_nth_tick(60, On60Ticks)
script.on_event(defines.events.on_chunk_generated, OnChunkGenerated)
script.on_event(defines.events.on_entity_died, OnEntityDied)
script.on_event(defines.events.script_raised_destroy, OnEntityDied)
script.on_event(defines.events.on_biter_base_built, OnBiterBaseBuilt)
script.on_event(defines.events.on_script_path_request_finished, OnScriptPathRequestFinished)
script.on_event(defines.events.on_player_died, OnPlayerDied)
