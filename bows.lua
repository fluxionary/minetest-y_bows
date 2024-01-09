local S = y_bows.S
local ci = y_bows.resources.craftitems

local function find_arrow_in_inv(user)
	local inv = user:get_inventory()
	for i = 1, inv:get_size("main") do
		local stack = inv:get_stack("main", i)
		if minetest.get_item_group(stack:get_name(), "y_bows_arrow") > 0 then
			return i, stack
		end
	end
end

function y_bows.register_bow(name, def)
	minetest.register_tool(name, {
		description = def.description,
		inventory_image = def.inventory_image,
		groups = { y_bows_bow = 1, y_bows_tool = 1 },
		_y_bows_crit_chance = def.crit_chance,
		_y_bows_speed_base = def.speed_base,
		_y_bows_draw_time = def.draw_time,
		on_use = function(itemstack, user, pointed_thing)
			if not minetest.is_player(user) then
				return
			end
			local i, arrows = find_arrow_in_inv(user)
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
	speed_base = 30 * 0.8,
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
	speed_base = 30 * 1.2,
	draw_time = 2,
	recipe = {
		{ ci.steel, ci.steel, ci.steel_wire },
		{ ci.steel, ci.steel_wire, "" },
		{ ci.steel_wire, "", "" },
	},
})
