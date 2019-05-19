local Gui = {}
local Constants = require("constants")

function Gui.DestroyGui(player)
    local modGui = player.gui.left["colonelwill-gui-flow"]
    if modGui ~= nil then
        modGui.destroy()
    end
end

function Gui.CreateGui(player)
    local guiFlow = player.gui.left.add {type = "flow", name = "colonelwill-gui-flow", style = "muppet_padded_vertical_flow", direction = "vertical"}

    local escapePodFrame = guiFlow.add {type = "frame", name = "colonelwill-escape-pod-frame", direction = "vertical", style = "muppet_padded_frame"}
    local techStatus = escapePodFrame.add {type = "label", name = "colonelwill-tech-label-", caption = {"gui-caption.colonelwill-tech-label-v2", global.Mod.escapeTechLevelsDone, global.Mod.escapeTechLevelsRequired}, style = "muppet_large_bold_text"}
    if global.Mod.escapeTechCompleted then
        techStatus.style.font_color = Constants.Color.green
    end
    escapePodFrame.add {type = "label", name = "colonelwill-workforce-recruited-label-v2", caption = {"gui-caption.colonelwill-recruited-label-v2", (#game.connected_players - 1), global.Mod.recruitedWorkforceCount}, tooltip = {"gui-tooltip.colonelwill-recruited-label-v2"}, style = "muppet_large_bold_text"}

    local fundingFrame = guiFlow.add {type = "frame", name = "colonelwill-funding-frame", direction = "vertical", style = "muppet_padded_frame"}
    fundingFrame.add {type = "label", name = "colonelwill-funding-header-label", caption = {"gui-caption.colonelwill-funding-header-label-v2"}, style = "muppet_large_bold_text"}
    fundingFrame.add {type = "label", name = "colonelwill-funding-part-label", caption = {"gui-caption.colonelwill-funding-part-label-v2"}, style = "muppet_bold_text"}
    fundingFrame.add {type = "label", name = "colonelwill-funding-tier1-label", caption = {"gui-caption.colonelwill-funding-tier1-label-v2"}, style = "muppet_bold_text"}
    fundingFrame.add {type = "label", name = "colonelwill-funding-tier2-label", caption = {"gui-caption.colonelwill-funding-tier2-label-v2"}, style = "muppet_bold_text"}
    fundingFrame.add {type = "label", name = "colonelwill-funding-tier3-label", caption = {"gui-caption.colonelwill-funding-tier3-label-v2"}, style = "muppet_bold_text"}
    fundingFrame.add {type = "label", name = "colonelwill-funding-bits-label", caption = {"gui-caption.colonelwill-funding-bits-label-v2"}, style = "muppet_bold_text"}
    fundingFrame.add {type = "label", name = "colonelwill-funding-donation-label", caption = {"gui-caption.colonelwill-funding-donation-label-v2"}, style = "muppet_bold_text"}
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

return Gui
