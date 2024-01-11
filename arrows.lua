local f = string.format

local S = y_bows.S
local ci = y_bows.resources.craftitems

function y_bows.register_arrow(name, def)
	y_bows.register_projectile(name, "y_bows_arrow", def)
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
				damage_groups = { fleshy = 12 },
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
				damage_groups = { fleshy = 16 },
			},
		},
	},
})

y_bows.register_arrow("y_bows:arrow_fire", {
	description = S("fire arrow"),
	inventory_image = "y_bows_arrow_fire.png",
	recipe = diagonal(ci.torch, ci.oil, ci.feather),
	parameters = {
		drag = {
			coefficient = 0.2,
		},
		punch = {
			tool_capabilities = {
				damage_groups = { fire = 6 },
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
				damage_groups = { fleshy = 14 },
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
				damage_groups = { fleshy = 12 },
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
				damage_groups = { fleshy = 8 },
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
		inventory_image = "y_bows_arrow_wood.png^[colorize:" .. dye .. ":100",
		recipe = diagonal("dye:" .. dye, ci.stick, ci.feather),
		properties = {
			--colors = {dye},  -- this doesn't work for unknown reasons
			textures = { f("y_bows_arrow_mesh.png^[colorize:%s:128", dye) },
		},
	})
end
