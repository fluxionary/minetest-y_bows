local f = string.format

local S = y_bows.S

y_bows.hud_icon = futil.define_hud("y_bows:icon", {
	enabled_by_default = true,
	get_hud_def = function(player, data)
		local wielded_item = player:get_wielded_item()

		if minetest.get_item_group(wielded_item:get_name(), "y_bows_weapon") then
			local tool_def = wielded_item:get_definition()
			local _, projectiles = y_bows.util.find_in_inv(player, tool_def._y_bows_projectile_group)
			if projectiles then
				local projectile_def = projectiles:get_definition()
				local image = f(
					"%s^(%s^[transformFX)",
					tool_def.inventory_image or tool_def.wield_image,
					projectile_def.inventory_image or projectile_def.wield_image
				)

				return {
					hud_elem_type = "image",
					text = image,
					scale = { x = 3, y = 3 },
					position = { x = 0.5, y = 0.5 },
					alignment = { x = 0, y = 0 },
					offset = { x = 0, y = -200 },
				}
			end
		end

		return {
			hud_elem_type = "image",
			text = "blank.png",
			scale = { x = 3, y = 3 },
			position = { x = 0.5, y = 0.5 },
			alignment = { x = 0, y = 0 },
			offset = { x = 0, y = -200 },
		}
	end,
})

y_bows.hud_background = futil.define_hud("y_bows:background", {
	enabled_by_default = true,
	get_hud_def = function(player, data)
		local wielded_item = player:get_wielded_item()

		if minetest.get_item_group(wielded_item:get_name(), "y_bows_weapon") then
			local tool_def = wielded_item:get_definition()
			local _, projectiles = y_bows.util.find_in_inv(player, tool_def._y_bows_projectile_group)
			if projectiles then
				return {
					hud_elem_type = "statbar",
					text = "[combine:16x16^[noalpha^[colorize:#000000:255",
					number = 40,
					direction = 0, -- left to right
					position = { x = 0.5, y = 0.35 },
					alignment = { x = 0, y = 0 },
					offset = { x = -160, y = 0 },
					size = { x = 16, y = 16 },
					z_index = -1,
				}
			end
		end

		return {
			hud_elem_type = "statbar",
			text = "[combine:16x16^[noalpha^[colorize:#000000:255",
			number = 0,
			direction = 0, -- left to right
			position = { x = 0.5, y = 0.35 },
			alignment = { x = 0, y = 0 },
			offset = { x = -160, y = 0 },
			size = { x = 16, y = 16 },
			z_index = -1,
		}
	end,
})

y_bows.hud_foreground = futil.define_hud("y_bows:foreground", {
	enabled_by_default = true,
	get_hud_def = function(player, data)
		local wielded_item = player:get_wielded_item()

		if minetest.get_item_group(wielded_item:get_name(), "y_bows_weapon") then
			local tool_def = wielded_item:get_definition()
			local _, projectiles = y_bows.util.find_in_inv(player, tool_def._y_bows_projectile_group)
			if projectiles then
				local meta = player:get_meta()
				local elapsed = meta:get_float("y_bows:drawing_elapsed")
				local draw_time = tool_def._y_bows_draw_time

				return {
					hud_elem_type = "statbar",
					text = "[combine:16x16^[noalpha^[colorize:#00ff00:255",
					number = math.round(40 * (elapsed / draw_time)),
					direction = 0, -- left to right
					position = { x = 0.5, y = 0.35 },
					alignment = { x = 0, y = 0 },
					offset = { x = -160, y = 0 },
					size = { x = 16, y = 16 },
				}
			end
		end

		return {
			hud_elem_type = "statbar",
			text = "[combine:16x16^[noalpha^[colorize:#00ff00:255",
			number = 0,
			direction = 0, -- left to right
			position = { x = 0.5, y = 0.35 },
			alignment = { x = 0, y = 0 },
			offset = { x = -160, y = 0 },
			size = { x = 16, y = 16 },
		}
	end,
})

minetest.register_chatcommand("y_bows:hud", {
	description = S("toggle y_bows drawing HUD"),
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, "you must be logged in"
		end
		local enabled = y_bows.hud_icon:toggle_enabled(player)
		y_bows.hud_background:set_enabled(player, enabled)
		y_bows.hud_foreground:set_enabled(player, enabled)
		if enabled then
			return true, "y_bows drawing hud enabled"
		else
			return true, "y_bows drawing hud disabled"
		end
	end,
})
