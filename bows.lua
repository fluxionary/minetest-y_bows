local S = y_bows.S
local ci = y_bows.resources.craftitems

function y_bows.register_bow(name, def)
	minetest.register_tool(name, {
		description = def.description,
		inventory_image = def.inventory_image,
		groups = { y_bows_bow = 1 },
	})
end

y_bows.register_bow("y_bows:bow_wood", {
	description = S("wooden bow"),
	inventory_image = "y_bows_bow_wood.png",
	uses = 185,
	crit_chance = 2,
	strength = 0.8,
	charge_time = 1,
	recipe = {
		{ ci.stick, ci.stick, ci.string },
		{ ci.stick, ci.string, "" },
		{ ci.string, "", "" },
	},
})

y_bows.register_bow("y_bows:bow_steel", {
	description = S("steel bow"),
	inventory_image = "y_bows_bow_steel.png",
	uses = 285,
	crit_chance = 5,
	strength = 1.0,
	charge_time = 1.4,
	recipe = {
		{ ci.stick, ci.stick, ci.string },
		{ ci.stick, ci.string, "" },
		{ ci.string, "", "" },
	},
})
