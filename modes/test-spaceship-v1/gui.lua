local Gui = {}
local GUIUtil = require("utility/gui-util")

local maxTestLevel = 7

function Gui.DestroyGui(player)
    GUIUtil.DestroyElementInPlayersReferenceStorage(player.index, "status", "frame")
    GUIUtil.DestroyElementInPlayersReferenceStorage(player.index, "welcome", "frame")
    GUIUtil.DestroyElementInPlayersReferenceStorage(player.index, "won", "frame")
    GUIUtil.RemovePlayersReferenceStorage(player.index)
end

function Gui.CreateGui(player)
    GUIUtil.CreatePlayersElementReferenceStorage(player.index)
    local statusFrame = GUIUtil.AddElement({parent = player.gui.left, name = "status", type = "frame", direction = "vertical", style = "muppet_margin_frame"}, true)
    local statusTable = GUIUtil.AddElement({parent = statusFrame, name = "status", type = "table", column_count = 2, style = "muppet_padded_table"}, false)
    for stageCount = 1, maxTestLevel do
        Gui.CreateStatusStage(statusTable, stageCount)
    end
    Gui.UpdatePlayer(player)
end

function Gui.RefreshPlayer(player)
    Gui.DestroyGui(player)
    Gui.CreateGui(player)
end

function Gui.RefreshAll()
    for _, player in pairs(game.connected_players) do
        Gui.RefreshPlayer(player)
    end
end

function Gui.GuiClickedEvent(eventData)
    local player = game.get_player(eventData.player_index)
    local clickedElement = eventData.element
    if clickedElement.name == GUIUtil.GenerateName("welcome", "button") then
        Gui.CloseWelcomePlayer(player)
    elseif clickedElement.name == GUIUtil.GenerateName("won", "button") then
        Gui.CloseWonPlayer(player)
    end
end

function Gui.CreateStatusStage(statusTable, stageCount)
    GUIUtil.AddElement({parent = statusTable, name = "statusStageName" .. stageCount, type = "label", caption = {"item-name.test-spaceship-v1-" .. stageCount}}, false)
    local stateElm = GUIUtil.AddElement({parent = statusTable, name = "statusStageState" .. stageCount, type = "label", caption = ""}, true)
    stateElm.style.left_padding = 10
end

function Gui.UpdatePlayer(player)
    for stageCount = 1, maxTestLevel do
        local stageStateElm = GUIUtil.GetElementFromPlayersReferenceStorage(player.index, "statusStageState" .. stageCount, "label")
        if global.currrentTestLevel > stageCount then
            stageStateElm.caption = {"gui-caption.test-spaceship-v1-completed"}
            stageStateElm.style.font_color = {r = 0.09, g = 0.7, b = 0, a = 1}
        elseif global.currrentTestLevel == stageCount then
            stageStateElm.caption = {"gui-caption.test-spaceship-v1-current"}
            stageStateElm.style.font_color = {r = 255, g = 153, b = 51}
        else
            stageStateElm.caption = {"gui-caption.test-spaceship-v1-future"}
        end
    end
end

function Gui.CreateWelcomePlayer(player)
    local id = player.index
    if global.PlayersWelcomeClosed[id] == nil or not global.PlayersWelcomeClosed then
        global.PlayersWelcomeClosed[id] = false
        local frame = GUIUtil.AddElement({parent = player.gui.left, name = "welcome", type = "frame", direction = "vertical", style = "muppet_margin_frame"}, true)
        local message = GUIUtil.AddElement({parent = frame, name = "welcome", type = "label", caption = {"gui-caption.test-spaceship-v1-welcome"}}, false)
        message.style.single_line = false
        local buttonFrame = GUIUtil.AddElement({parent = frame, name = "welcomeButtonFrame", type = "flow", direction = "horizontal"}, false)
        buttonFrame.style.horizontally_stretchable = true
        buttonFrame.style.horizontal_align = "right"
        GUIUtil.AddElement({parent = buttonFrame, name = "welcome", type = "button", caption = {"gui-caption.test-spaceship-v1-continue"}, style = "confirm_button"}, false)
    end
end

function Gui.CloseWelcomePlayer(player)
    global.PlayersWelcomeClosed[player.index] = true
    GUIUtil.DestroyElementInPlayersReferenceStorage(player.index, "welcome", "frame")
end

function Gui.CreateWonPlayer(player)
    local id = player.index
    if global.gameFinished and (global.PlayersWonClosed[id] == nil or not global.PlayersWonClosed) then
        global.PlayersWonClosed[id] = false
        local frame = GUIUtil.AddElement({parent = player.gui.left, name = "won", type = "frame", direction = "vertical", style = "muppet_margin_frame"}, true)
        local message = GUIUtil.AddElement({parent = frame, name = "won", type = "label", caption = {"gui-caption.test-spaceship-v1-won"}}, false)
        message.style.single_line = false
        local buttonFrame = GUIUtil.AddElement({parent = frame, name = "wonButtonFrame", type = "flow", direction = "horizontal"}, false)
        buttonFrame.style.horizontally_stretchable = true
        buttonFrame.style.horizontal_align = "right"
        GUIUtil.AddElement({parent = buttonFrame, name = "won", type = "button", caption = {"gui-caption.test-spaceship-v1-continue"}, style = "confirm_button"}, false)
    end
end

function Gui.CloseWonPlayer(player)
    global.PlayersWonClosed[player.index] = true
    GUIUtil.DestroyElementInPlayersReferenceStorage(player.index, "won", "frame")
end

return Gui
