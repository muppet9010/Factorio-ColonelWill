local modeFilePath = "modes/escape-pod-v1"
local Commands = require("utility/commands")
local Utils = require("utility/utils")
local Gui = require(modeFilePath .. "/gui.lua")

local function EscapePodAddPart(command)
    local value = command.parameter
end

local function OnRocketLaunched(event)
    local rocket = event.rocket
    if rocket == nil or not rocket.valid then
        return
    end
    for name, count in pairs(rocket.get_inventory(defines.inventory.rocket).get_contents()) do
        if name == "escape-pod" and count > 0 and not global.Mod.gameFinished then
            global.Mod.gameFinished = true
            game.set_game_state {game_finished = true, player_won = true, can_continue = true, victorious_force = rocket.force}
        end
    end
end

local function OnResearchFinished(event)
    local technology = event.research
    if technology.name ~= "recruit-workforce-member" then
        return
    end
    global.Mod.recruitedWorkforceCount = technology.level - 1
    Gui.RefreshAll()
end

local function OnPlayerJoined(event)
    local player = game.get_player(event.player_index)
    Gui.OnPlayerJoined(player)
end

local function CreateGlobals()
    global.Mod = global.Mod or {}
    global.Mod.gameFinished = global.Mod.gameFinished or false
    global.Mod.recruitedWorkforceCount = global.Mod.recruitedWorkforceCount or 0
end

local function OnLoad()
    Commands.Register("escape_pod_add_cost", {"api-description.escape_pod_add_cost"}, EscapePodAddPart, true)
    Utils.DisableSiloScript()
end

local function OnStartup()
    CreateGlobals()
    OnLoad()
end

script.on_init(OnStartup)
script.on_load(OnLoad)
script.on_configuration_changed(OnStartup)
script.on_event(defines.events.on_rocket_launched, OnRocketLaunched)
script.on_event(defines.events.on_research_finished, OnResearchFinished)
script.on_event(defines.events.on_player_joined_game, OnPlayerJoined)
