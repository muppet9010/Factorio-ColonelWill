local mode = settings.startup["colonelwill_mode"].value
if mode == "none" then
    return
else
    require("modes/" .. mode .. "/control")
end
