if settings.startup["colonelwill_mode"].value ~= "test-spaceship-v1" then
    return
end

data:extend(
    {
        {
            type = "item",
            name = "test-spaceship-v1-1",
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            icon_size = 128,
            subgroup = "intermediate-product",
            order = "m[satellite]a",
            stack_size = 1
        },
        {
            type = "item",
            name = "test-spaceship-v1-2",
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            icon_size = 128,
            subgroup = "intermediate-product",
            order = "m[satellite]a",
            stack_size = 1
        },
        {
            type = "item",
            name = "test-spaceship-v1-3",
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            icon_size = 128,
            subgroup = "intermediate-product",
            order = "m[satellite]a",
            stack_size = 1
        },
        {
            type = "item",
            name = "test-spaceship-v1-4",
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            icon_size = 128,
            subgroup = "intermediate-product",
            order = "m[satellite]a",
            stack_size = 1
        },
        {
            type = "item",
            name = "test-spaceship-v1-5",
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            icon_size = 128,
            subgroup = "intermediate-product",
            order = "m[satellite]a",
            stack_size = 1
        },
        {
            type = "item",
            name = "test-spaceship-v1-6",
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            icon_size = 128,
            subgroup = "intermediate-product",
            order = "m[satellite]a",
            stack_size = 1
        },
        {
            type = "item",
            name = "test-spaceship-v1-7",
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            icon_size = 128,
            subgroup = "intermediate-product",
            order = "m[satellite]a",
            stack_size = 1
        },
        {
            type = "recipe",
            name = "test-spaceship-v1-1",
            energy_required = 60,
            enabled = false,
            category = "crafting",
            ingredients = {
                {"nuclear-reactor", 500}
            },
            result = "test-spaceship-v1-1",
            requester_paste_multiplier = 1
        },
        {
            type = "recipe",
            name = "test-spaceship-v1-2",
            energy_required = 60,
            enabled = false,
            category = "crafting",
            ingredients = {
                {"electric-engine-unit", 50000}
            },
            result = "test-spaceship-v1-2",
            requester_paste_multiplier = 1
        },
        {
            type = "recipe",
            name = "test-spaceship-v1-3",
            energy_required = 60,
            enabled = false,
            category = "crafting",
            ingredients = {
                {"personal-laser-defense-equipment", 5000}
            },
            result = "test-spaceship-v1-3",
            requester_paste_multiplier = 1
        },
        {
            type = "recipe",
            name = "test-spaceship-v1-4",
            energy_required = 60,
            enabled = false,
            category = "crafting",
            ingredients = {
                {"rocket-fuel", 50000}
            },
            result = "test-spaceship-v1-4",
            requester_paste_multiplier = 1
        },
        {
            type = "recipe",
            name = "test-spaceship-v1-5",
            energy_required = 60,
            enabled = false,
            category = "crafting",
            ingredients = {
                {"low-density-structure", 50000}
            },
            result = "test-spaceship-v1-5",
            requester_paste_multiplier = 1
        },
        {
            type = "recipe",
            name = "test-spaceship-v1-6",
            energy_required = 60,
            enabled = false,
            category = "crafting",
            ingredients = {
                {"satellite", 100}
            },
            result = "test-spaceship-v1-6",
            requester_paste_multiplier = 1
        },
        {
            type = "recipe",
            name = "test-spaceship-v1-7",
            energy_required = 60,
            enabled = false,
            category = "crafting",
            ingredients = {
                {"beacon", 500},
                {"speed-module-3", 1000}
            },
            result = "test-spaceship-v1-7",
            requester_paste_multiplier = 1
        },
        {
            type = "technology",
            name = "test-spaceship-v1-1",
            icon_size = 128,
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            enabled = true,
            localised_name = {"technology-name.test-spaceship-v1-1"},
            localised_description = {"technology-description.test-spaceship-v1-1"},
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "test-spaceship-v1-1"
                }
            },
            prerequisites = {},
            unit = {
                count = "25000",
                ingredients = {
                    {"automation-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            order = "zzz"
        },
        {
            type = "technology",
            name = "test-spaceship-v1-2",
            icon_size = 128,
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            localised_name = {"technology-name.test-spaceship-v1-2"},
            localised_description = {"technology-description.test-spaceship-v1-2"},
            enabled = true,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "test-spaceship-v1-2"
                }
            },
            prerequisites = {"logistic-science-pack", "test-spaceship-v1-1"},
            unit = {
                count = "50000",
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
            name = "test-spaceship-v1-3",
            icon_size = 128,
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            localised_name = {"technology-name.test-spaceship-v1-3"},
            localised_description = {"technology-description.test-spaceship-v1-3"},
            enabled = true,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "test-spaceship-v1-3"
                }
            },
            prerequisites = {"military-science-pack", "test-spaceship-v1-2"},
            unit = {
                count = "75000",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            order = "zzz"
        },
        {
            type = "technology",
            name = "test-spaceship-v1-4",
            icon_size = 128,
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            localised_name = {"technology-name.test-spaceship-v1-4"},
            localised_description = {"technology-description.test-spaceship-v1-4"},
            enabled = true,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "test-spaceship-v1-4"
                }
            },
            prerequisites = {"chemical-science-pack", "test-spaceship-v1-3"},
            unit = {
                count = "100000",
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1},
                    {"chemical-science-pack", 1}
                },
                time = 60
            },
            upgrade = true,
            order = "zzz"
        },
        {
            type = "technology",
            name = "test-spaceship-v1-5",
            icon_size = 128,
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            localised_name = {"technology-name.test-spaceship-v1-5"},
            localised_description = {"technology-description.test-spaceship-v1-5"},
            enabled = true,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "test-spaceship-v1-5"
                }
            },
            prerequisites = {"production-science-pack", "test-spaceship-v1-4"},
            unit = {
                count = "150000",
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
            order = "zzz"
        },
        {
            type = "technology",
            name = "test-spaceship-v1-6",
            icon_size = 128,
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            localised_name = {"technology-name.test-spaceship-v1-6"},
            localised_description = {"technology-description.test-spaceship-v1-6"},
            enabled = true,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "test-spaceship-v1-6"
                }
            },
            prerequisites = {"utility-science-pack", "test-spaceship-v1-5"},
            unit = {
                count = "200000",
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
            order = "zzz"
        },
        {
            type = "technology",
            name = "test-spaceship-v1-7",
            icon_size = 128,
            icon = "__base__/graphics/technology/demo/analyse-ship.png",
            localised_name = {"technology-name.test-spaceship-v1-7"},
            localised_description = {"technology-description.test-spaceship-v1-7"},
            enabled = true,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "test-spaceship-v1-7"
                }
            },
            prerequisites = {"space-science-pack", "test-spaceship-v1-6"},
            unit = {
                count = "250000",
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
            order = "zzz"
        }
    }
)

data:extend(
    {
        {
            type = "sprite",
            name = "test-spaceship-v1-info-icon",
            filename = "__base__/graphics/icons/info.png",
            size = 33
        }
    }
)
