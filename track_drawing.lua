minetest.register_globalstep(function(dtime)
	local players = minetest.get_connected_players()
	for i = 1, #players do
		local player = players[i]
		local meta = player:get_meta()
		local wielded_item = player:get_wielded_item()
		if minetest.get_item_group(wielded_item:get_name(), "y_bows_tool") > 0 then
			local def = wielded_item:get_definition()
			meta:set_float(
				"y_bows:drawing_elapsed",
				math.min(meta:get_float("y_bows:drawing_elapsed") + dtime, def._y_bows_draw_time)
			)
		else
			meta:set_string("y_bows:drawing_elapsed", "")
		end
	end
end)
