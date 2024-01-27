local previous_index_by_player_name = {}
local previous_item_by_player_name = {}
local previous_projectile_by_player_name = {}

minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	previous_index_by_player_name[player_name] = player:get_wield_index()
	local wielded_item = player:get_wielded_item()
	previous_item_by_player_name[player_name] = wielded_item
	if minetest.get_item_group(wielded_item:get_name(), "y_bows_weapon") > 0 then
		local _, projectile = y_bows.util.find_in_inv(player, wielded_item:get_definition()._y_bows_projectile_group)
		previous_projectile_by_player_name[player_name] = projectile
	end
end)

minetest.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()
	previous_index_by_player_name[player_name] = nil
	previous_item_by_player_name[player_name] = nil
	previous_projectile_by_player_name[player_name] = nil
end)

minetest.register_globalstep(function(dtime)
	local players = minetest.get_connected_players()
	for i = 1, #players do
		local player = players[i]
		local meta = player:get_meta()
		local wield_index = player:get_wield_index()
		local wielded_item = player:get_wielded_item()
		local wielded_def = wielded_item:get_definition()
		local wielding_bow_weapon = minetest.get_item_group(wielded_item:get_name(), "y_bows_weapon") > 0
		local projectile
		if wielding_bow_weapon then
			projectile = select(2, y_bows.util.find_in_inv(player, wielded_def._y_bows_projectile_group))
		end
		local player_name = player:get_player_name()
		local previous_index = previous_index_by_player_name[player_name]
		local previous_item = previous_item_by_player_name[player_name]
		local previous_projectile = previous_projectile_by_player_name[player_name]

		if
			wield_index == previous_index
			and wielded_item == previous_item
			and wielding_bow_weapon
			and projectile
			and projectile == previous_projectile
		then
			local prev_elapsed = meta:get_float("y_bows:drawing_elapsed")
			local elapsed = math.min(prev_elapsed + dtime, wielded_def._y_bows_draw_time)
			meta:set_float("y_bows:drawing_elapsed", elapsed)
			meta:set_string("y_bows:drawing_name", wielded_item:get_name())
			if prev_elapsed < wielded_def._y_bows_draw_time and elapsed == wielded_def._y_bows_draw_time then
				minetest.sound_play({ name = "y_bows_bow_loaded" }, { to_player = player:get_player_name() })
			end
		elseif wielding_bow_weapon then
			meta:set_float("y_bows:drawing_elapsed", 0)
			meta:set_string("y_bows:drawing_name", wielded_item:get_name())

			minetest.sound_play({ name = "y_bows_bow_load" }, { to_player = player:get_player_name() })
		else
			meta:set_string("y_bows:drawing_elapsed", "")
			meta:set_string("y_bows:drawing_name", "")
		end
		previous_index_by_player_name[player_name] = wield_index
		previous_item_by_player_name[player_name] = wielded_item
		previous_projectile_by_player_name[player_name] = projectile
	end
end)
