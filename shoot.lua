function y_bows.shoot(entity_name, shooter, weapon, projectile)
	if minetest.get_item_group(weapon:get_name(), "y_bows_weapon") == 0 then
		return
	end
	local weapon_def = weapon:get_definition()
	if minetest.get_item_group(projectile:get_name(), weapon_def._y_bows_projectile_group) == 0 then
		return
	end
	local base_speed = weapon_def._y_bows_base_speed
	local crit_chance = weapon_def._y_bows_crit_chance
	local draw_time = weapon_def._y_bows_draw_time
	local shooter_meta = shooter:get_meta()
	local drawing_elapsed = shooter_meta:get_float("y_bows:drawing_elapsed")
	local speed = base_speed * math.min(drawing_elapsed, draw_time) / draw_time
	local projectile_def = projectile:get_definition()
	local parameters = table.copy(projectile_def._ybows_parameters)
	local damage_groups = ((parameters.punch or {}).tool_capabilities or {}).damage_groups
	local crit = damage_groups and crit_chance <= 100 * math.random()
	if crit then
		for damage_group, value in pairs(damage_groups) do
			damage_groups[damage_group] = 2 * value
		end
		-- TODO: change particles and sounds?
	end
	shooter_meta:set_string("y_bows:drawing_elapsed", "")
	local obj = ballistics.player_shoots(entity_name, shooter, speed, nil, parameters)
	if obj then
		if crit then
			minetest.sound_play({ name = "y_bows_bow_shoot_crit" }, { pos = obj:get_pos() }, true)
		else
			minetest.sound_play({ name = "y_bows_bow_shoot" }, { pos = obj:get_pos() }, true)
		end
	end
	return obj
end
