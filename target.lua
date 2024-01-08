local S = y_bows.S
local ci = y_bows.resources.craftitems

minetest.register_node("y_bows:target", {
	description = S("Straw"),
	tiles = { "y_bows_target.png" },
	is_ground_content = false,
	groups = { snappy = 3, flammable = 4, fall_damage_add_percent = -30 },
	sounds = y_bows.resources.sounds.target,
})

minetest.register_craft({
	type = "fuel",
	recipe = "y_bows:target",
	burntime = 3,
})

if ci.target_core and ci.target_face then
	minetest.register_craft({
		output = "y_bows:target",
		recipe = {
			{ "", ci.target_face, "" },
			{ ci.target_face, ci.target_core, ci.target_face },
			{ "", ci.target_face, "" },
		},
	})
end
