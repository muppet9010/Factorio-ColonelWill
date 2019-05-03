local Constants = require("constants")
local modeFilePath = "modes/escape-pod-v2"

if settings.startup["colonelwill_mode"].value ~= "escape-pod-v2" then
    return
end

data:extend(
    {
        {
            type = "item",
            name = "escape-pod-v2",
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            icon_size = 128,
            subgroup = "intermediate-product",
            order = "m[satellite]a",
            place_result = "escape-pod-v2",
            stack_size = 1
        },
        {
            type = "recipe",
            name = "escape-pod-v2",
            energy_required = 5,
            enabled = false,
            category = "crafting",
            ingredients = {
                {"low-density-structure", 100},
                {"solar-panel", 100},
                {"accumulator", 100},
                {"radar", 5},
                {"processing-unit", 100},
                {"rocket-fuel", 50},
                {"raw-fish", 1}
            },
            result = "escape-pod-v2",
            requester_paste_multiplier = 1
        },
        {
            type = "car",
            name = "escape-pod-v2",
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            icon_size = 128,
            flags = {"hide-alt-info"},
            collision_box = {{-1, -1}, {1, 1}},
            collision_mask = {"ground-tile", "water-tile"},
            weight = 1,
            braking_force = 1,
            friction = 1,
            energy_per_hit_point = 1,
            animation = {
                width = 1,
                height = 1,
                frame_count = 1,
                direction_count = 1,
                filename = "__core__/graphics/empty.png"
            },
            effectivity = 0.6,
            consumption = "0kW",
            rotation_speed = 0,
            energy_source = {
                type = "void"
            },
            inventory_size = 0
        },
        {
            type = "technology",
            name = "escape-pod-v2-1",
            icon_size = 128,
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            effects = {
                {
                    type = "nothing",
                    effect_description = {"technology-modifier.espace-pod"}
                }
            },
            prerequisites = {"logistic-science-pack"},
            unit = {
                count = "1000",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            max_level = 5,
            order = "zzz"
        },
        {
            type = "technology",
            name = "escape-pod-v2-6",
            icon_size = 128,
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            effects = {
                {
                    type = "nothing",
                    effect_description = {"technology-modifier.espace-pod"}
                }
            },
            prerequisites = {"escape-pod-v2-1", "chemical-science-pack", "military-science-pack"},
            unit = {
                count = 1000,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1},
                    {"chemical-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            max_level = 10,
            order = "zzz"
        },
        {
            type = "technology",
            name = "escape-pod-v2-11",
            icon_size = 128,
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            effects = {
                {
                    type = "nothing",
                    effect_description = {"technology-modifier.espace-pod"}
                }
            },
            prerequisites = {"escape-pod-v2-6", "production-science-pack"},
            unit = {
                count = 1000,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            max_level = 15,
            order = "zzz"
        },
        {
            type = "technology",
            name = "escape-pod-v2-16",
            icon_size = 128,
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            effects = {
                {
                    type = "nothing",
                    effect_description = {"technology-modifier.espace-pod"}
                }
            },
            prerequisites = {"escape-pod-v2-11", "utility-science-pack"},
            unit = {
                count = 1000,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            max_level = 20,
            order = "zzz"
        },
        {
            type = "technology",
            name = "escape-pod-v2-21",
            icon_size = 128,
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            effects = {
                {
                    type = "nothing",
                    effect_description = {"technology-modifier.espace-pod"}
                }
            },
            prerequisites = {"escape-pod-v2-16", "space-science-pack"},
            unit = {
                count = 1000,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"space-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            max_level = "infinite",
            order = "zzz"
        },
        {
            type = "technology",
            name = "recruit-workforce-member-v2-1",
            icon_size = 114,
            icon = Constants.AssetModName .. "/" .. modeFilePath .. "/graphics/technology/recruit-workforce-member.png",
            prerequisites = {"logistic-science-pack"},
            unit = {
                count_formula = "5000",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            max_level = 1,
            order = "zzz"
        },
        {
            type = "technology",
            name = "recruit-workforce-member-v2-2",
            icon_size = 114,
            icon = Constants.AssetModName .. "/" .. modeFilePath .. "/graphics/technology/recruit-workforce-member.png",
            prerequisites = {"recruit-workforce-member-v2-1", "chemical-science-pack", "military-science-pack"},
            unit = {
                count_formula = "5000",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1},
                    {"chemical-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            max_level = 2,
            order = "zzz"
        },
        {
            type = "technology",
            name = "recruit-workforce-member-v2-3",
            icon_size = 114,
            icon = Constants.AssetModName .. "/" .. modeFilePath .. "/graphics/technology/recruit-workforce-member.png",
            prerequisites = {"recruit-workforce-member-v2-2", "production-science-pack"},
            unit = {
                count_formula = "5000",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            max_level = 3,
            order = "zzz"
        },
        {
            type = "technology",
            name = "recruit-workforce-member-v2-4",
            icon_size = 114,
            icon = Constants.AssetModName .. "/" .. modeFilePath .. "/graphics/technology/recruit-workforce-member.png",
            prerequisites = {"recruit-workforce-member-v2-3", "utility-science-pack"},
            unit = {
                count_formula = "5000",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            max_level = 4,
            order = "zzz"
        },
        {
            type = "technology",
            name = "recruit-workforce-member-v2-5",
            icon_size = 114,
            icon = Constants.AssetModName .. "/" .. modeFilePath .. "/graphics/technology/recruit-workforce-member.png",
            prerequisites = {"recruit-workforce-member-v2-4", "space-science-pack"},
            unit = {
                count_formula = "2^(L-4)*2500",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"space-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            max_level = "10",
            order = "zzz"
        }
    }
)

local defaultStyle = data.raw["gui-style"]["default"]
defaultStyle.muppet_padded_horizontal_flow = {
    type = "horizontal_flow_style",
    left_padding = 4,
    top_padding = 4
}
defaultStyle.muppet_padded_vertical_flow = {
    type = "vertical_flow_style",
    left_padding = 4,
    top_padding = 4
}
defaultStyle.muppet_mod_button_sprite = {
    type = "button_style",
    width = 36,
    height = 36,
    scalable = true
}
--same size as a button
defaultStyle.muppet_button_sprite = {
    type = "button_style",
    width = 42,
    height = 42,
    scalable = true
}
defaultStyle.muppet_gui_frame = {
    type = "frame_style",
    left_padding = 4,
    top_padding = 4
}
defaultStyle.muppet_padded_table = {
    type = "table_style",
    top_padding = 5,
    bottom_padding = 5,
    left_padding = 5,
    right_padding = 5
}
defaultStyle.muppet_padded_table_cell = {
    type = "label_style",
    top_padding = 5,
    bottom_padding = 5,
    left_padding = 5,
    right_padding = 5
}
defaultStyle.muppet_small_button = {
    type = "button_style",
    padding = 2,
    font = "default"
}
defaultStyle.muppet_large_text = {
    type = "label_style",
    font = "default-large"
}
