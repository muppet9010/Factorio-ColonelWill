local Constants = require("constants")
local modeFilePath = "modes/chat-hunts-will-v1"

if settings.startup["colonelwill_mode"].value ~= "chat-hunts-will-v1" then
    return
end

data:extend(
    {
        {
            type = "item",
            name = "colonelwill-chat-hunts-will-v1-escape-pod",
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            icon_size = 128,
            subgroup = "intermediate-product",
            order = "m[satellite]a",
            place_result = "colonelwill-chat-hunts-will-v1-escape-pod",
            stack_size = 1
        },
        {
            type = "recipe",
            name = "colonelwill-chat-hunts-will-v1-escape-pod",
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
            result = "colonelwill-chat-hunts-will-v1-escape-pod",
            requester_paste_multiplier = 1
        },
        {
            type = "car",
            name = "colonelwill-chat-hunts-will-v1-escape-pod",
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
            name = "colonelwill-chat-hunts-will-v1-escape-pod",
            icon_size = 128,
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "colonelwill-chat-hunts-will-v1-escape-pod"
                }
            },
            prerequisites = {"space-science-pack"},
            unit = {
                count = "5000",
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
            upgrade = false,
            order = "zzz"
        },
        {
            type = "technology",
            name = "colonelwill-chat-hunts-will-v1-recruit-workforce-member-1",
            icon_size = 114,
            icon = Constants.AssetModName .. "/" .. modeFilePath .. "/graphics/technology/recruit-workforce-member.png",
            prerequisites = {},
            unit = {
                count_formula = "500",
                ingredients = {
                    {"automation-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            max_level = 1,
            order = "zzz"
        },
        {
            type = "technology",
            name = "colonelwill-chat-hunts-will-v1-recruit-workforce-member-2",
            icon_size = 114,
            icon = Constants.AssetModName .. "/" .. modeFilePath .. "/graphics/technology/recruit-workforce-member.png",
            prerequisites = {"colonelwill-chat-hunts-will-v1-recruit-workforce-member-1", "logistic-science-pack"},
            unit = {
                count_formula = "500",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            max_level = 2,
            order = "zzz"
        },
        {
            type = "technology",
            name = "colonelwill-chat-hunts-will-v1-recruit-workforce-member-3",
            icon_size = 114,
            icon = Constants.AssetModName .. "/" .. modeFilePath .. "/graphics/technology/recruit-workforce-member.png",
            prerequisites = {"colonelwill-chat-hunts-will-v1-recruit-workforce-member-2", "military-science-pack"},
            unit = {
                count_formula = "500",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            max_level = 3,
            order = "zzz"
        },
        {
            type = "technology",
            name = "colonelwill-chat-hunts-will-v1-recruit-workforce-member-4",
            icon_size = 114,
            icon = Constants.AssetModName .. "/" .. modeFilePath .. "/graphics/technology/recruit-workforce-member.png",
            prerequisites = {"colonelwill-chat-hunts-will-v1-recruit-workforce-member-3", "chemical-science-pack"},
            unit = {
                count_formula = "500",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1},
                    {"chemical-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            max_level = 4,
            order = "zzz"
        },
        {
            type = "technology",
            name = "colonelwill-chat-hunts-will-v1-recruit-workforce-member-5",
            icon_size = 114,
            icon = Constants.AssetModName .. "/" .. modeFilePath .. "/graphics/technology/recruit-workforce-member.png",
            prerequisites = {"colonelwill-chat-hunts-will-v1-recruit-workforce-member-4", "production-science-pack"},
            unit = {
                count_formula = "500",
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
            max_level = "5",
            order = "zzz"
        },
        {
            type = "technology",
            name = "colonelwill-chat-hunts-will-v1-recruit-workforce-member-6",
            icon_size = 114,
            icon = Constants.AssetModName .. "/" .. modeFilePath .. "/graphics/technology/recruit-workforce-member.png",
            prerequisites = {"colonelwill-chat-hunts-will-v1-recruit-workforce-member-5", "utility-science-pack"},
            unit = {
                count_formula = "2^(L-4)*2500",
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
            max_level = "6",
            order = "zzz"
        },
        {
            type = "technology",
            name = "colonelwill-chat-hunts-will-v1-recruit-workforce-member-7",
            icon_size = 114,
            icon = Constants.AssetModName .. "/" .. modeFilePath .. "/graphics/technology/recruit-workforce-member.png",
            prerequisites = {"colonelwill-chat-hunts-will-v1-recruit-workforce-member-6", "space-science-pack"},
            unit = {
                count_formula = "500",
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
            max_level = "7",
            order = "zzz"
        }
    }
)
