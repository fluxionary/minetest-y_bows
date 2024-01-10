local f = string.format

local S = y_bows.S
local s = y_bows.settings
local ci = y_bows.resources.craftitems

function y_bows.register_slingshot(name, def)
	minetest.register_tool(name, {
		description = f(
			"%s\n%s\n%s\n%s",
			def.description,
			minetest.colorize("green", S("crit chance: @1%", def.crit_chance)),
			minetest.colorize("cyan", S("base speed: @1", def.base_speed)),
			minetest.colorize("red", S("draw time: @1", def.draw_time))
		),
		short_description = def.description,
		inventory_image = def.inventory_image,
		groups = { y_bows_bow = 1, y_bows_weapon = 1 },
		_y_bows_crit_chance = def.crit_chance,
		_y_bows_base_speed = def.base_speed,
		_y_bows_draw_time = def.draw_time,
		_y_bows_projectile_group = "y_bows_slingshot_ammo",
		on_use = function(itemstack, user, pointed_thing)
			if not minetest.is_player(user) then
				return
			end
			local i, ammo = y_bows.util.find_in_inv(user, "y_bows_slingshot_ammo")
			if not i and ammo then
				return
			end
			if not y_bows.shoot("y_bows:slingshot_ammo", user, itemstack, ammo:peek_item()) then
				-- shooting failed for some reason, don't do anything
				return
			end
			if def.uses and not minetest.is_creative_enabled(user:get_player_name()) then
				itemstack:set_wear(minetest.get_tool_wear_after_use(def.uses, itemstack:get_wear()))
				local inv = user:get_inventory()
				ammo:take_item()
				inv:set_stack("main", i, ammo)
			end
			return itemstack
		end,
	})

	y_bows.util.register_craft_if_valid(name, def.recipe)
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
