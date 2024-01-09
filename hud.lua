y_bows.hud = futil.register_hud("y_bows:drawing", {
	enabled_by_default = true,
	get_hud_def = function(player, data)
		return {}
	end,
})

minetest.register_chatcommand("y_bows:hud", {
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, "you must be logged in"
		end
		if y_bows.hud:toggle_enabled(player) then
			return true, "y_bows drawing hud enabled"
		else
			return true, "y_bows drawing hud disabled"
		end
	end,
})
