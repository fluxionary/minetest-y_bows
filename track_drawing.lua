local previous_index_by_player_name = {}
local previous_item_by_player_name = {}

minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	previous_index_by_player_name[player_name] = player:get_wield_index()
	previous_item_by_player_name[player_name] = player:get_wielded_item()
end)

minetest.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()
	previous_index_by_player_name[player_name] = nil
	previous_item_by_player_name[player_name] = nil
end)

minetest.register_globalstep(function(dtime)
	local players = minetest.get_connected_players()
	for i = 1, #players do
		local player = players[i]
		local meta = player:get_meta()
		local wield_index = player:get_wield_index()
		local wielded_item = player:get_wielded_item()
		local player_name = player:get_player_name()
		local previous_index = previous_index_by_player_name[player_name]
		local previous_item = previous_item_by_player_name[player_name]
		if
			wield_index == previous_index
			and wielded_item == previous_item
			and minetest.get_item_group(wielded_item:get_name(), "y_bows_weapon") > 0
		then
			local def = wielded_item:get_definition()
			local prev_elapsed = meta:get_float("y_bows:drawing_elapsed")
			local elapsed = math.min(prev_elapsed + dtime, def._y_bows_draw_time)
			meta:set_float("y_bows:drawing_elapsed", elapsed)
			if prev_elapsed < def._y_bows_draw_time and elapsed == def._y_bows_draw_time then
				minetest.sound_play({ name = "y_bows_bow_load" }, { to_player = player:get_player_name() })
			end
		else
			meta:set_string("y_bows:drawing_elapsed", "")
		end
		previous_index_by_player_name[player_name] = wield_index
		previous_item_by_player_name[player_name] = wielded_item
	end
end)
