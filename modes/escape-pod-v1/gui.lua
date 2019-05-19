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

    local escapePodFrame = guiFlow.add {type = "frame", name = "colonelwill-escape-pod-frame", direction = "vertical", style = "muppet_gui_frame"}
    local techStatus = escapePodFrame.add {type = "label", name = "colonelwill-tech-label", caption = {"gui-caption.colonelwill-tech-label", global.Mod.escapeTechLevelsDone, global.Mod.escapeTechLevelsRequired}, style = "muppet_large_text"}
    if global.Mod.escapeTechCompleted then
        techStatus.style.font_color = {r = 0.09, g = 0.7, b = 0, a = 1}
    end
    escapePodFrame.add {type = "label", name = "colonelwill-levels-label", caption = {"gui-caption.colonelwill-levels-label", global.Mod.escapeTechLevelsAdded}, style = "muppet_large_text"}
    escapePodFrame.add {type = "label", name = "colonelwill-workforce-recruited-label", caption = {"gui-caption.colonelwill-recruited-label", (#game.connected_players - 1), global.Mod.recruitedWorkforceCount}, tooltip = {"gui-tooltip.colonelwill-recruited-label"}, style = "muppet_large_text"}

    local fundingFrame = guiFlow.add {type = "frame", name = "colonelwill-funding-frame", direction = "vertical", style = "muppet_gui_frame"}
    fundingFrame.add {type = "label", name = "colonelwill-funding-header-label", caption = {"gui-caption.colonelwill-funding-header-label"}, style = "muppet_large_text"}
    fundingFrame.add {type = "label", name = "colonelwill-funding-part-label", caption = {"gui-caption.colonelwill-funding-part-label"}}
    fundingFrame.add {type = "label", name = "colonelwill-funding-tier1-label", caption = {"gui-caption.colonelwill-funding-tier1-label"}}
    fundingFrame.add {type = "label", name = "colonelwill-funding-tier2-label", caption = {"gui-caption.colonelwill-funding-tier2-label"}}
    fundingFrame.add {type = "label", name = "colonelwill-funding-tier3-label", caption = {"gui-caption.colonelwill-funding-tier3-label"}}
    fundingFrame.add {type = "label", name = "colonelwill-funding-bits-label", caption = {"gui-caption.colonelwill-funding-bits-label"}}
    fundingFrame.add {type = "label", name = "colonelwill-funding-donation-label", caption = {"gui-caption.colonelwill-funding-donation-label"}}
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
