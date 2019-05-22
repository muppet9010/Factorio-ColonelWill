local Gui = {}
local GUIUtil = require("utility/gui-util")

function Gui.DestroyGui(player)
    GUIUtil.DestroyElementInPlayersReferenceStorage(player.index, "status", "frame")
    GUIUtil.DestroyElementInPlayersReferenceStorage(player.index, "welcome", "frame")
    GUIUtil.DestroyElementInPlayersReferenceStorage(player.index, "firstStageDone", "frame")
    GUIUtil.DestroyElementInPlayersReferenceStorage(player.index, "won", "frame")
    GUIUtil.RemovePlayersReferenceStorage(player.index)
end

function Gui.CreateGui(player)
    GUIUtil.CreatePlayersElementReferenceStorage(player.index)
    local statusFrame = GUIUtil.AddElement({parent = player.gui.left, name = "status", type = "frame", direction = "vertical", style = "muppet_margin_frame"}, true)
    statusFrame.style.width = 300

    local titleFlow = GUIUtil.AddElement({parent = statusFrame, name = "title", type = "flow", direction = "horizontal"}, false)
    titleFlow.style.vertical_align = "center"
    GUIUtil.AddElement({parent = titleFlow, name = "title", type = "label", caption = {"gui-caption.test-spaceship-v1-status-title"}, style = "muppet_large_bold_text"}, false)
    local infoButtonFlow = GUIUtil.AddElement({parent = titleFlow, name = "info", type = "flow", direction = "vertical"}, false)
    infoButtonFlow.style.horizontally_stretchable = true
    infoButtonFlow.style.horizontal_align = "right"
    local infoButton = GUIUtil.AddElement({parent = infoButtonFlow, name = "info", type = "sprite-button", sprite = "test-spaceship-v1-info-icon"}, false)
    infoButton.style.height = 24
    infoButton.style.width = 24

    local statusTable = GUIUtil.AddElement({parent = statusFrame, name = "status", type = "table", column_count = 2, style = "muppet_padded_table"}, false)
    for stageCount = 1, 7 do
        Gui.CreateStatusStage(statusTable, stageCount)
    end
    if global.firstStageDone then
        Gui.CreateStatusStage(statusTable, 8)
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
    elseif clickedElement.name == GUIUtil.GenerateName("firstStageDone", "button") then
        Gui.CloseFirstStageDonePlayer(player)
    elseif clickedElement.name == GUIUtil.GenerateName("won", "button") then
        Gui.CloseWonPlayer(player)
    elseif clickedElement.name == GUIUtil.GenerateName("info", "sprite-button") then
        Gui.ShowMessages(player)
    end
end

function Gui.CreateStatusStage(statusTable, stageCount)
    GUIUtil.AddElement({parent = statusTable, name = "statusStageName" .. stageCount, type = "label", caption = {"item-name.test-spaceship-v1-" .. stageCount}, style = "muppet_bold_text"}, false)
    local stateElm = GUIUtil.AddElement({parent = statusTable, name = "statusStageState" .. stageCount, type = "label", caption = "", style = "muppet_bold_text"}, true)
    stateElm.style.left_padding = 10
end

function Gui.UpdatePlayer(player)
    for stageCount = 1, 8 do
        local stageStateElm = GUIUtil.GetElementFromPlayersReferenceStorage(player.index, "statusStageState" .. stageCount, "label")
        if stageStateElm ~= nil then
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
end

function Gui.ShowMessages(player)
    local id = player.index
    global.PlayersWelcomeClosed[id] = false
    global.PlayersFirstStageDoneClosed[id] = false
    global.PlayersWonClosed[id] = false

    Gui.CreateWelcomePlayer(player)
    Gui.CreateFirstStageDonePlayer(player)
    Gui.CreateWonPlayer(player)
end

function Gui.CreateWelcomePlayer(player)
    local id = player.index
    if (global.PlayersWelcomeClosed[id] == nil or global.PlayersWelcomeClosed[id] == false) and (GUIUtil.GetElementFromPlayersReferenceStorage(id, "welcome", "frame") == nil) then
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

function Gui.CreateFirstStageDonePlayer(player)
    local id = player.index
    if (global.firstStageDone) and (global.PlayersFirstStageDoneClosed[id] == nil or global.PlayersFirstStageDoneClosed[id] == false) and (GUIUtil.GetElementFromPlayersReferenceStorage(id, "firstStageDone", "frame") == nil) then
        global.PlayersFirstStageDoneClosed[id] = false
        local frame = GUIUtil.AddElement({parent = player.gui.left, name = "firstStageDone", type = "frame", direction = "vertical", style = "muppet_margin_frame"}, true)
        local message = GUIUtil.AddElement({parent = frame, name = "firstStageDone", type = "label", caption = {"gui-caption.test-spaceship-v1-firstStageDone"}}, false)
        message.style.single_line = false
        local buttonFrame = GUIUtil.AddElement({parent = frame, name = "firstStageDoneButtonFrame", type = "flow", direction = "horizontal"}, false)
        buttonFrame.style.horizontally_stretchable = true
        buttonFrame.style.horizontal_align = "right"
        GUIUtil.AddElement({parent = buttonFrame, name = "firstStageDone", type = "button", caption = {"gui-caption.test-spaceship-v1-continue"}, style = "confirm_button"}, false)
    end
end

function Gui.CloseFirstStageDonePlayer(player)
    global.PlayersFirstStageDoneClosed[player.index] = true
    GUIUtil.DestroyElementInPlayersReferenceStorage(player.index, "firstStageDone", "frame")
end

function Gui.CreateWonPlayer(player)
    local id = player.index
    if (global.gameFinished) and (global.PlayersWonClosed[id] == nil or global.PlayersWonClosed[id] == false) and (GUIUtil.GetElementFromPlayersReferenceStorage(id, "won", "frame") == nil) then
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
