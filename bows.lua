local f = string.format

local S = y_bows.S
local ci = y_bows.resources.craftitems

function y_bows.register_bow(name, def)
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
		_y_bows_projectile_group = "y_bows_arrow",
		on_use = function(itemstack, user, pointed_thing)
			if not minetest.is_player(user) then
				return
			end
			local i, arrows = y_bows.util.find_in_inv(user, "y_bows_arrow")
			if not (i and arrows) then
				return
			end
			if not y_bows.shoot("y_bows:arrow", user, itemstack, arrows:peek_item()) then
				-- shooting failed for some reason, don't do anything
				return
			end
			if def.uses and not minetest.is_creative_enabled(user:get_player_name()) then
				itemstack:set_wear(minetest.get_tool_wear_after_use(def.uses, itemstack:get_wear()))
				local inv = user:get_inventory()
				arrows:take_item()
				inv:set_stack("main", i, arrows)
			end
			return itemstack
		end,
	})

	y_bows.util.register_craft_if_valid(name, def.recipe)
end

y_bows.register_bow("y_bows:bow_wood", {
	description = S("wooden bow"),
	inventory_image = "y_bows_bow_wood.png",
	uses = 185,
	crit_chance = 2,
	base_speed = 30 * 0.8,
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
	base_speed = 30 * 1.2,
	draw_time = 2,
	recipe = {
		{ ci.steel, ci.steel, ci.steel_wire },
		{ ci.steel, ci.steel_wire, "" },
		{ ci.steel_wire, "", "" },
	},
})
