local S = y_bows.S
local s = y_bows.settings
local ci = y_bows.resources.craftitems

function y_bows.register_bow(name, def)
	y_bows.register_weapon(name, "y_bows_arrow", "y_bows:arrow", def)
end

y_bows.register_bow("y_bows:bow_wood", {
	description = S("wooden bow"),
	inventory_image = "y_bows_bow_wood.png",
	uses = 185,
	crit_chance = 2,
	base_speed = s.base_speed * 0.8,
	draw_time = 1,
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
	base_speed = s.base_speed * 1.2,
	draw_time = 2,
	recipe = {
		{ ci.steel, ci.steel, ci.steel_wire },
		{ ci.steel, ci.steel_wire, "" },
		{ ci.steel_wire, "", "" },
	},
})
