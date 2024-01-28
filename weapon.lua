local f = string.format

local S = y_bows.S

function y_bows.register_weapon(name, projectile_group, projectile_entity, def)
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
		_y_bows_projectile_group = projectile_group,
		on_use = function(itemstack, user, pointed_thing)
			if not minetest.is_player(user) then
				return
			end
			local i, projectile = y_bows.util.find_in_inv(user, projectile_group)
			if not (i and projectile) then
				return
			end
			if not y_bows.shoot(projectile_entity, user, itemstack, projectile:peek_item()) then
				-- shooting failed for some reason, don't do anything
				return
			end
			if not minetest.is_creative_enabled(user:get_player_name()) then
				if def.uses then
					itemstack:add_wear(minetest.get_tool_wear_after_use(def.uses, itemstack:get_wear()))
				end
				local inv = user:get_inventory()
				projectile:take_item()
				inv:set_stack("main", i, projectile)
			end
			return itemstack
		end,
	})

	y_bows.util.register_craft_if_valid(name, def.recipe)
end
