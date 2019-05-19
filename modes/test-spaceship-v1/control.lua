local modeFilePath = "modes/test-spaceship-v1"
local Utils = require("utility/utils")
local Gui = require(modeFilePath .. "/gui.lua")
local GUIUtil = require("utility/gui-util")

if settings.startup["colonelwill_mode"].value ~= "test-spaceship-v1" then
    return
end

local function PrintToAllPlayers(text, color)
    for _, player in pairs(game.connected_players) do
        player.print(text, color)
    end
end

local function OnRocketLaunched(event)
    local rocket = event.rocket
    for name in pairs(rocket.get_inventory(defines.inventory.rocket).get_contents()) do
        local s, e = string.find(name, "test-spaceship-v1-", 0, true)
        if s ~= nil then
            local itemLevel = tonumber(string.sub(name, e + 1))
            if itemLevel < global.currrentTestLevel then
                PrintToAllPlayers({"message.test-spaceship-v1-already-tested-item", {"item-name.test-spaceship-v1-" .. itemLevel}}, {r = 1, g = 0, b = 0, a = 1})
            elseif itemLevel == global.currrentTestLevel then
                PrintToAllPlayers({"message.test-spaceship-v1-completed-tested-item", {"item-name.test-spaceship-v1-" .. itemLevel}}, {r = 0, g = 1, b = 0, a = 1})
                global.currrentTestLevel = global.currrentTestLevel + 1
                Gui.RefreshAll()
            elseif itemLevel > global.currrentTestLevel then
                PrintToAllPlayers({"message.test-spaceship-v1-too-early-tested-item", {"item-name.test-spaceship-v1-" .. itemLevel}}, {r = 1, g = 0, b = 0, a = 1})
            end

            if global.currrentTestLevel > 7 and not global.gameFinished then
                global.gameFinished = true
                for _, player in pairs(game.connected_players) do
                    Gui.CreateWonPlayer(player)
                end
                game.set_game_state {game_finished = true, player_won = true, can_continue = true, victorious_force = rocket.force}
            end
        end
    end
end

local function CreateGlobals()
    global.gameFinished = global.gameFinished or false
    global.PlayersWelcomeClosed = global.PlayersWelcomeClosed or {}
    global.PlayersWonClosed = global.PlayersWonClosed or {}
    GUIUtil.CreateAllPlayersElementReferenceStorage()
    global.currrentTestLevel = global.currrentTestLevel or 1
end

local function OnLoad()
    Utils.DisableSiloScript()
end

local function OnStartup()
    Utils.DisableIntroMessage()
    CreateGlobals()
    OnLoad()
    Gui.RefreshAll()
end

local function OnPlayerJoined(event)
    local player = game.get_player(event.player_index)
    Gui.RefreshPlayer(player)
    Gui.CreateWelcomePlayer(player)
    Gui.CreateWonPlayer(player)
end

script.on_init(OnStartup)
script.on_load(OnLoad)
script.on_configuration_changed(OnStartup)
script.on_event(defines.events.on_rocket_launched, OnRocketLaunched)
script.on_event(defines.events.on_player_joined_game, OnPlayerJoined)
script.on_event(defines.events.on_gui_click, Gui.GuiClickedEvent)