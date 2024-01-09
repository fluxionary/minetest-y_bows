local S = y_bows.S
local ci = y_bows.resources.craftitems

function y_bows.register_arrow(name, def)
	local parameters = table.copy(def.parameters or {})
	parameters.drop_item = { item = name }

	minetest.register_craftitem(name, {
		description = def.description,
		inventory_image = def.inventory_image,
		groups = { y_bows_arrow = 1 },
		_ybows_parameters = parameters,
	})

	y_bows.util.register_craft_if_valid(name, def.recipe)
end

y_bows.register_arrow("y_bows:arrow_bronze", {
	description = S("bronze arrow"),
	inventory_image = "y_bows_arrow_bronze.png",
	recipe = {
		{ ci.flint, "", "" },
		{ "", ci.bronze, "" },
		{ "", "", ci.feather },
	},
	parameters = {
		drag = {
			coefficient = 0.1,
		},
		punch = {
			tool_capabilities = {
				damage_groups = { fleshy = 12 },
			},
		},
	},
})

y_bows.register_arrow("y_bows:arrow_diamond", {
	description = S("diamond arrow"),
	inventory_image = "y_bows_arrow_diamond.png",
	recipe = {
		{ ci.flint, "", "" },
		{ "", ci.diamond, "" },
		{ "", "", ci.feather },
	},
	parameters = {
		drag = {
			coefficient = 0.15,
		},
		punch = {
			tool_capabilities = {
				damage_groups = { fleshy = 16 },
			},
		},
	},
})

y_bows.register_arrow("y_bows:arrow_fire", {
	description = S("fire arrow"),
	inventory_image = "y_bows_arrow_fire.png",
	recipe = {
		{ ci.torch, "", "" },
		{ "", ci.oil, "" },
		{ "", "", ci.feather },
	},
	parameters = {
		drag = {
			coefficient = 0.2,
		},
		punch = {
			tool_capabilities = {
				damage_groups = { fire = 6 },
			},
		},
		replace = { replacement = ci.fire },
		remove_object = true,
	},
})

y_bows.register_arrow("y_bows:arrow_mese", {
	description = S("mese arrow"),
	inventory_image = "y_bows_arrow_mese.png",
	recipe = {
		{ ci.flint, "", "" },
		{ "", ci.mese_crystal, "" },
		{ "", "", ci.feather },
	},
	parameters = {
		drag = {
			coefficient = 0.15,
		},
		punch = {
			tool_capabilities = {
				damage_groups = { fleshy = 14 },
			},
		},
	},
})

y_bows.register_arrow("y_bows:arrow_steel", {
	description = S("steel arrow"),
	inventory_image = "y_bows_arrow_steel.png",
	recipe = {
		{ ci.flint, "", "" },
		{ "", ci.steel, "" },
		{ "", "", ci.feather },
	},
	parameters = {
		drag = {
			coefficient = 0.15,
		},
		punch = {
			tool_capabilities = {
				damage_groups = { fleshy = 12 },
			},
		},
	},
})

y_bows.register_arrow("y_bows:arrow_stone", {
	description = S("stone arrow"),
	inventory_image = "y_bows_arrow_stone.png",
	recipe = {
		{ ci.flint, "", "" },
		{ "", ci.stone, "" },
		{ "", "", ci.feather },
	},
	parameters = {
		drag = {
			coefficient = 0.15,
		},
		punch = {
			tool_capabilities = {
				damage_groups = { fleshy = 8 },
			},
		},
	},
})

y_bows.register_arrow("y_bows:arrow_wood", {
	description = S("wooden arrow"),
	inventory_image = "y_bows_arrow_wood.png",
	recipe = {
		{ ci.flint, "", "" },
		{ "", ci.stick, "" },
		{ "", "", ci.feather },
	},
	parameters = {
		drag = {
			coefficient = 0.2,
		},
		punch = {
			tool_capabilities = {
				damage_groups = { fleshy = 4 },
			},
		},
	},
})

-- dark gray and dark green are apparently intentionally absent
local default_dyes = {
	"black",
	"blue",
	"brown",
	"cyan",
	"green",
	"grey",
	"magenta",
	"orange",
	"pink",
	"red",
	"violet",
	"white",
	"yellow",
}

for i = 1, #default_dyes do
	local dye = default_dyes[i]

	y_bows.register_arrow("y_bows:arrow_training_" .. dye, {
		description = S(dye .. " training arrow"),
		inventory_image = "x_bows_arrow_wood.png^[colorize:" .. dye .. ":100",
		recipe = {
			{ "dye:" .. dye, "", "" },
			{ "", ci.stick, "" },
			{ "", "", ci.feather },
		},
	})
end
