local Gui = {}

function Gui.DestroyGui(player)
    local modGui = player.gui.left["colonelwill-gui-flow"]
    if modGui ~= nil then
        modGui.destroy()
    end
end

function Gui.CreateGui(player)
    local guiFlow = player.gui.left.add {type = "flow", name = "colonelwill-gui-flow", style = "muppet_padded_vertical_flow", direction = "vertical"}

    local escapePodFrame = guiFlow.add {type = "frame", name = "colonelwill-escape-pod-frame", direction = "vertical", style = "muppet_gui_frame"}

    local workforceFrame = guiFlow.add {type = "frame", name = "colonelwill-workforce-frame", direction = "vertical", style = "muppet_gui_frame"}
    local workforceRecruitedLabel = workforceFrame.add {type = "label", name = "colonelwill-workforce-recruited-label", caption = {"gui-caption.recruited-label", global.Mod.recruitedWorkforceCount}, tooltip = {"gui-tooltip.recruited-label"}}
    workforceRecruitedLabel.style.font = "default-large"
end

function Gui.OnPlayerJoined(player)
    Gui.RefreshPlayer(player)
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
