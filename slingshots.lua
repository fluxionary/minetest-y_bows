local S = y_bows.S
local s = y_bows.settings
local ci = y_bows.resources.craftitems

function y_bows.register_slingshot(name, def)
	y_bows.register_weapon(name, "y_bows_slingshot_ammo", "y_bows:slingshot_ammo", def)
end

y_bows.register_slingshot("y_bows:slingshot_wood", {
	description = S("wooden slingshot"),
	inventory_image = "y_bows_slingshot_wood.png",
	uses = 85,
	crit_chance = 2,
	base_speed = s.base_speed * 0.7,
	draw_time = 0.25,
	recipe = {
		{ "", ci.stick, ci.string },
		{ "", ci.stick, ci.stick },
		{ ci.stick, "", "" },
	},
})

y_bows.register_slingshot("y_bows:slingshot_steel", {
	description = S("steel slingshot"),
	inventory_image = "y_bows_slingshot_steel.png",
	uses = 135,
	crit_chance = 5,
	base_speed = s.base_speed * 1.0,
	draw_time = 0.5,
	recipe = {
		{ "", ci.steel, ci.steel_wire },
		{ "", ci.steel, ci.steel },
		{ ci.steel, "", "" },
	},
})
