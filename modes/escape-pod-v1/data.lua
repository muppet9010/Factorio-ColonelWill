local Constants = require("constants")
local modeFilePath = "modes/escape-pod-v1"

if settings.startup["colonelwill_mode"].value ~= "escape-pod-v1" then
    return
end

data:extend(
    {
        {
            type = "item",
            name = "escape-pod",
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            icon_size = 128,
            subgroup = "intermediate-product",
            order = "m[satellite]a",
            place_result = "escape-pod",
            stack_size = 1
        },
        {
            type = "recipe",
            name = "escape-pod",
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
            result = "escape-pod",
            requester_paste_multiplier = 1
        },
        {
            type = "car",
            name = "escape-pod",
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            icon_size = 128,
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
            consumption = "1kW",
            rotation_speed = 0,
            energy_source = {
                type = "void"
            },
            inventory_size = 0
        },
        {
            type = "technology",
            name = "escape-pod-1",
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
                count = 5000,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            order = "zzz"
        },
        {
            type = "technology",
            name = "escape-pod-2",
            icon_size = 128,
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            effects = {
                {
                    type = "nothing",
                    effect_description = {"technology-modifier.espace-pod"}
                }
            },
            prerequisites = {"escape-pod-1", "chemical-science-pack"},
            unit = {
                count = 5000,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            order = "zzz"
        },
        {
            type = "technology",
            name = "escape-pod-3",
            icon_size = 128,
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            effects = {
                {
                    type = "nothing",
                    effect_description = {"technology-modifier.espace-pod"}
                }
            },
            prerequisites = {"escape-pod-2", "production-science-pack"},
            unit = {
                count = 5000,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            order = "zzz"
        },
        {
            type = "technology",
            name = "escape-pod-4",
            icon_size = 128,
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            effects = {
                {
                    type = "nothing",
                    effect_description = {"technology-modifier.espace-pod"}
                }
            },
            prerequisites = {"escape-pod-3", "utility-science-pack"},
            unit = {
                count = 5000,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            order = "zzz"
        },
        {
            type = "technology",
            name = "escape-pod-5",
            localised_name = {"technology-name.escape-pod-shiny-bit"},
            localised_description = {"technology-description.escape-pod-shiny-bit"},
            icon_size = 128,
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            effects = {
                {
                    type = "nothing",
                    effect_description = {"technology-modifier.espace-pod"}
                }
            },
            prerequisites = {"escape-pod-4", "space-science-pack"},
            unit = {
                count = 1000,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
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
            name = "recruit-workforce-member",
            icon_size = 114,
            icon = Constants.AssetModName .. "/" .. modeFilePath .. "/graphics/technology/recruit-workforce-member.png",
            prerequisites = {"space-science-pack", "military-science-pack"},
            unit = {
                count_formula = "2^L*5000",
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
