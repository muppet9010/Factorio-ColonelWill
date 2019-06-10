local modeFilePath = "modes/escape-pod-v2"
local Commands = require("utility/commands")
local Utils = require("utility/utils")
local Gui = require(modeFilePath .. "/gui.lua")
local Logging = require("utility/logging")

if settings.startup["colonelwill_mode"].value ~= "escape-pod-v2" then
    return
end

local function EscapePodAddPart(command)
    local rawValue = command.parameter
    local value = tonumber(rawValue)
    if type(value) ~= "number" then
        game.print("escape_pod_add_level value '" .. rawValue .. "' not a valid number")
        return
    end
    game.print("escape_pod_add_level added " .. value .. " levels")
    global.Mod.escapeTechLevelsRequired = global.Mod.escapeTechLevelsRequired + value
    Gui.RefreshAll()
end

local function OnRocketLaunched(event)
    local rocket = event.rocket
    if rocket == nil or not rocket.valid then
        return
    end
    for name, count in pairs(rocket.get_inventory(defines.inventory.rocket).get_contents()) do
        if name == "escape-pod-v2" and count > 0 and not global.Mod.gameFinished then
            global.Mod.gameFinished = true
            game.set_game_state {game_finished = true, player_won = true, can_continue = true, victorious_force = rocket.force}
        end
    end
end

local function WorkforceResearchCompleted(newLevel)
    local debug = false
    global.Mod.recruitedWorkforceCount = newLevel
    if global.Mod.escapeTechCompleted then
        return
    end
    local oldLevel = newLevel - 1
    local baseName = "escape-pod-v2"
    local oldTechnologyNameRange = baseName .. "-w" .. oldLevel .. "-"
    local maxTechResearchedLevel = 0
    for _, tech in pairs(game.forces["player"].technologies) do
        local s, e = string.find(tech.name, oldTechnologyNameRange, 0, true)
        if s ~= nil then
            local nameBaseLevel = tonumber(string.sub(tech.name, e + 1))
            local researchedLevel = tech.level
            Logging.LogPrint(researchedLevel .. " - " .. nameBaseLevel, debug)
            if researchedLevel > nameBaseLevel then
                if not tech.researched then
                    researchedLevel = researchedLevel - 1
                end
                Logging.LogPrint(tech.name .. ": " .. researchedLevel .. " - " .. tostring(tech.researched), debug)
                if researchedLevel > maxTechResearchedLevel then
                    maxTechResearchedLevel = researchedLevel
                end
            end
            tech.level = nameBaseLevel
            tech.researched = false
            tech.enabled = false
        end
    end
    Logging.LogPrint("maxTechResearchedLevel: " .. maxTechResearchedLevel, debug)
    local newTechnologyNameRange = baseName .. "-w" .. newLevel .. "-"
    for _, tech in pairs(game.forces["player"].technologies) do
        local s, e = string.find(tech.name, newTechnologyNameRange, 0, true)
        if s ~= nil then
            tech.enabled = true
            local nameBaseLevel = tonumber(string.sub(tech.name, e + 1))
            Logging.LogPrint(tech.name .. ": " .. tech.prototype.max_level .. " - " .. nameBaseLevel, debug)
            if maxTechResearchedLevel >= tech.prototype.max_level then
                Logging.LogPrint("researched", debug)
                tech.level = tech.prototype.max_level
                tech.researched = true
            elseif maxTechResearchedLevel >= nameBaseLevel then
                Logging.LogPrint("level = " .. maxTechResearchedLevel, debug)
                tech.level = maxTechResearchedLevel + 1
            end
        end
    end
end

local function OnResearchFinished(event)
    local technology = event.research
    if string.find(technology.name, "recruit-workforce-member-v2", 0, true) then
        if technology.level == 10 and technology.researched then
            WorkforceResearchCompleted(10)
        elseif technology.level >= 5 then
            WorkforceResearchCompleted(technology.level - 1)
        else
            WorkforceResearchCompleted(technology.level)
        end
        Gui.RefreshAll()
    elseif string.find(technology.name, "escape-pod-v2", 0, true) and not global.Mod.escapeTechCompleted then
        local newTechLevel = technology.level
        if not technology.researched then
            newTechLevel = newTechLevel - 1
        end
        if newTechLevel > global.Mod.escapeTechLevelsDone then
            global.Mod.escapeTechLevelsDone = newTechLevel
        end
        local force = technology.force
        if global.Mod.escapeTechLevelsDone == global.Mod.escapeTechLevelsRequired then
            force.recipes["escape-pod-v2"].enabled = true
            technology.enabled = false
            game.print("Escape Pod Unlocked", {r = 0.09, g = 0.7, b = 0, a = 1})
            global.Mod.escapeTechCompleted = true
        elseif string.find(technology.name, "escape%-pod%-v2%-w+%d%-21") then
            local alreadyQueued = false
            for _, queuedResearch in pairs(force.research_queue) do
                if queuedResearch.name == technology.name then
                    alreadyQueued = true
                    break
                end
            end
            if not alreadyQueued then
                force.add_research(technology.name)
            end
        end
        Gui.RefreshAll()
    end
end

local function PlayersChanged()
    Gui.RefreshAll()
end

local function CreateGlobals()
    global.Mod = global.Mod or {}
    global.Mod.gameFinished = global.Mod.gameFinished or false
    if global.Mod.recruitedWorkforceCount == nil then
        WorkforceResearchCompleted(0)
    end
    global.Mod.escapeTechLevelsRequired = global.Mod.escapeTechLevelsRequired or 25
    global.Mod.escapeTechLevelsDone = global.Mod.escapeTechLevelsDone or 0
    global.Mod.escapeTechCompleted = global.Mod.escapeTechCompleted or false
end

local function OnLoad()
    Commands.Register("escape_pod_add_level", {"api-description.escape_pod_add_level-v2"}, EscapePodAddPart, true)
    Utils.DisableSiloScript()
end

local function OnStartup()
    CreateGlobals()
    OnLoad()
    Gui.RefreshAll()
end

script.on_init(OnStartup)
script.on_load(OnLoad)
script.on_configuration_changed(OnStartup)
script.on_event(defines.events.on_rocket_launched, OnRocketLaunched)
script.on_event(defines.events.on_research_finished, OnResearchFinished)
script.on_event(defines.events.on_player_joined_game, PlayersChanged)
script.on_event(defines.events.on_player_left_game, PlayersChanged)
