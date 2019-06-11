local Gui = {}
local GuiUtil = require("utility/gui-util")

function Gui.GuiRecreateAll()
    for _, player in pairs(game.connected_players) do
        Gui.GuiRecreate(player)
    end
end

function Gui.GuiRecreate(player)
    Gui.DestroyGui(player)
    Gui.CreateGui(player)
end

function Gui.DestroyGui(player)
    GuiUtil.DestroyElementInPlayersReferenceStorage(player.index, "colonelwill-gui", "flow")
    GuiUtil.RemovePlayersReferenceStorage(player.index)
end

function Gui.CreateGui(player)
    GuiUtil.CreatePlayersElementReferenceStorage(player.index)

    local guiFlow = GuiUtil.AddElement({parent = player.gui.left, name = "colonelwill-gui", type = "flow", style = "muppet_padded_vertical_flow", direction = "vertical"}, true)

    local statusFrame = GuiUtil.AddElement({parent = guiFlow, name = "colonelwill-status", type = "frame", direction = "vertical", style = "muppet_padded_frame"})
    GuiUtil.AddElement({parent = statusFrame, name = "workforce-recruited", type = "label", caption = "", tooltip = {"gui-tooltip.colonelwill-chat-hunts-will-v1-workforce-recruited-label"}, style = "muppet_large_bold_text"}, true)
    GuiUtil.AddElement({parent = statusFrame, name = "biter-count", type = "label", caption = "", style = "muppet_large_bold_text"}, true)
    GuiUtil.AddElement({parent = statusFrame, name = "biter-frequency", type = "label", caption = {"gui-caption.colonelwill-chat-hunts-will-v1-biter-frequency-label"}, style = "muppet_bold_text"})
    GuiUtil.AddElement({parent = statusFrame, name = "biter-evolution", type = "label", caption = {"gui-caption.colonelwill-chat-hunts-will-v1-biter-evolution-label"}, style = "muppet_bold_text"})

    local fundingFrame = GuiUtil.AddElement({parent = guiFlow, name = "colonelwill-funding", type = "frame", direction = "vertical", style = "muppet_padded_frame"})
    GuiUtil.AddElement({parent = fundingFrame, name = "funding-title", type = "label", caption = {"gui-caption.colonelwill-chat-hunts-will-v1-funding-title-label"}, style = "muppet_large_bold_text"})
    GuiUtil.AddElement({parent = fundingFrame, name = "biter-funding-100", type = "label", caption = {"gui-caption.colonelwill-chat-hunts-will-v1-biter-funding-100-label"}, style = "muppet_bold_text"})
    GuiUtil.AddElement({parent = fundingFrame, name = "biter-funding-50", type = "label", caption = {"gui-caption.colonelwill-chat-hunts-will-v1-biter-funding-50-label"}, style = "muppet_bold_text"})
    GuiUtil.AddElement({parent = fundingFrame, name = "biter-funding-25", type = "label", caption = {"gui-caption.colonelwill-chat-hunts-will-v1-biter-funding-25-label"}, style = "muppet_bold_text"})
    GuiUtil.AddElement({parent = fundingFrame, name = "biter-funding-10", type = "label", caption = {"gui-caption.colonelwill-chat-hunts-will-v1-biter-funding-10-label"}, style = "muppet_bold_text"})
    GuiUtil.AddElement({parent = fundingFrame, name = "biter-funding-5", type = "label", caption = {"gui-caption.colonelwill-chat-hunts-will-v1-biter-funding-5-label"}, style = "muppet_bold_text"})
    GuiUtil.AddElement({parent = fundingFrame, name = "biter-funding-1", type = "label", caption = {"gui-caption.colonelwill-chat-hunts-will-v1-biter-funding-1-label"}, style = "muppet_bold_text"})

    Gui.RefreshPlayer(player)
end

function Gui.RefreshPlayer(player)
    GuiUtil.GetElementFromPlayersReferenceStorage(player.index, "workforce-recruited", "label").caption = {"gui-caption.colonelwill-chat-hunts-will-v1-workforce-recruited-label", (#game.connected_players - 1), global.recruitedWorkforceCount}
    GuiUtil.GetElementFromPlayersReferenceStorage(player.index, "biter-count", "label").caption = {"gui-caption.colonelwill-chat-hunts-will-v1-biter-count-label", global.nextBiterAttackCount}

    if global.biterAttackStatus == "none" then
        GuiUtil.DestroyElementInPlayersReferenceStorage(player.index, "colonelwill-attack-status", "frame")
    else
        local attackFrame = GuiUtil.GetElementFromPlayersReferenceStorage(player.index, "colonelwill-attack-status", "frame")
        if attackFrame == nil then
            local guiFlow = GuiUtil.GetElementFromPlayersReferenceStorage(player.index, "colonelwill-gui", "flow")
            attackFrame = GuiUtil.AddElement({parent = guiFlow, name = "colonelwill-attack-status", type = "frame", direction = "vertical", style = "muppet_padded_frame"}, true)
        end
        if #attackFrame.children > 0 then
            attackFrame.children[1].destroy()
        end
        if global.biterAttackStatus == "comming" then
            local statusElm = GuiUtil.AddElement({parent = attackFrame, name = "colonelwill-attack-status", type = "label", caption = {"gui-caption.colonelwill-chat-hunts-will-v1-attack-comming-label", global.biterCurrentAttackCurrentSize}, style = "muppet_large_bold_text"})
            statusElm.style.font_color = {r = 1, g = 0.5, b = 0.5, a = 1}
        elseif global.biterAttackStatus == "will-won" then
            local statusElm = GuiUtil.AddElement({parent = attackFrame, name = "colonelwill-attack-status", type = "label", caption = {"gui-caption.colonelwill-chat-hunts-will-v1-attack-will-won-label", global.biterCurrentAttackStartingSize}, style = "muppet_large_bold_text"})
            statusElm.style.font_color = {r = 0.09, g = 0.7, b = 0, a = 1}
        elseif global.biterAttackStatus == "will-lost" then
            local statusElm = GuiUtil.AddElement({parent = attackFrame, name = "colonelwill-attack-status", type = "label", caption = {"gui-caption.colonelwill-chat-hunts-will-v1-attack-will-lost-label", global.biterCurrentAttackStartingSize}, style = "muppet_large_bold_text"})
            statusElm.style.font_color = {r = 1, g = 0, b = 0, a = 1}
        end
    end
end

function Gui.RefreshAll()
    for _, player in pairs(game.connected_players) do
        Gui.RefreshPlayer(player)
    end
end

return Gui
