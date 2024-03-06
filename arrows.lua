local f = string.format

local S = y_bows.S
local ci = y_bows.resources.craftitems

local damage_multiplier = y_bows.settings.damage_multiplier

function y_bows.register_arrow(name, def)
	y_bows.register_ammo(name, "y_bows_arrow", def)
end

local function diagonal(a, b, c)
	return {
		{ a, "", "" },
		{ "", b, "" },
		{ "", "", c },
	}
end

y_bows.register_arrow("y_bows:arrow_bronze", {
	description = S("bronze arrow"),
	inventory_image = "y_bows_arrow_bronze.png",
	recipe = diagonal(ci.flint, ci.bronze, ci.feather),
	parameters = {
		drag = {
			coefficient = 0.1,
		},
		punch = {
			tool_capabilities = {
				damage_groups = { fleshy = 6 * damage_multiplier },
			},
		},
	},
})

y_bows.register_arrow("y_bows:arrow_diamond", {
	description = S("diamond arrow"),
	inventory_image = "y_bows_arrow_diamond.png",
	recipe = diagonal(ci.flint, ci.diamond, ci.feather),
	parameters = {
		drag = {
			coefficient = 0.15,
		},
		punch = {
			tool_capabilities = {
				damage_groups = { fleshy = 8 * damage_multiplier },
			},
		},
	},
})

y_bows.register_arrow("y_bows:arrow_fire", {
	description = S("fire arrow"),
	inventory_image = "y_bows_arrow_fire.png",
	recipe = diagonal(ci.torch, ci.oil, ci.feather),
	light_source = minetest.LIGHT_MAX,
	parameters = {
		drag = {
			coefficient = 0.2,
		},
		punch = {
			tool_capabilities = {
				damage_groups = { fire = 3 * damage_multiplier },
			},
		},
		replace = {
			replacement = ci.fire,
		},
	},
})

y_bows.register_arrow("y_bows:arrow_mese", {
	description = S("mese arrow"),
	inventory_image = "y_bows_arrow_mese.png",
	recipe = diagonal(ci.flint, ci.mese_crystal, ci.feather),
	parameters = {
		drag = {
			coefficient = 0.1,
		},
		punch = {
			tool_capabilities = {
				damage_groups = { fleshy = 7 * damage_multiplier },
			},
		},
	},
})

y_bows.register_arrow("y_bows:arrow_steel", {
	description = S("steel arrow"),
	inventory_image = "y_bows_arrow_steel.png",
	recipe = diagonal(ci.flint, ci.steel, ci.feather),
	parameters = {
		drag = {
			coefficient = 0.15,
		},
		punch = {
			tool_capabilities = {
				damage_groups = { fleshy = 6 * damage_multiplier },
			},
		},
	},
})

y_bows.register_arrow("y_bows:arrow_stone", {
	description = S("stone arrow"),
	inventory_image = "y_bows_arrow_stone.png",
	recipe = diagonal(ci.flint, ci.stone, ci.feather),
	parameters = {
		drag = {
			coefficient = 0.15,
		},
		punch = {
			tool_capabilities = {
				damage_groups = { fleshy = 4 * damage_multiplier },
			},
		},
	},
})

y_bows.register_arrow("y_bows:arrow_wood", {
	description = S("wooden arrow"),
	inventory_image = "y_bows_arrow_wood.png",
	recipe = diagonal(ci.flint, ci.stick, ci.feather),
	parameters = {
		drag = {
			coefficient = 0.2,
		},
		punch = {
			tool_capabilities = {
				damage_groups = { fleshy = 2 * damage_multiplier },
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
		inventory_image = "y_bows_arrow_wood.png^[colorize:" .. dye .. ":100",
		recipe = diagonal("dye:" .. dye, ci.stick, ci.feather),
		properties = {
			--colors = {dye},  -- this doesn't work for unknown reasons
			textures = { f("y_bows_arrow_mesh.png^[colorize:%s:128", dye) },
		},
		parameters = {
			drag = {
				coefficient = 0.2,
			},
		},
	})
end
