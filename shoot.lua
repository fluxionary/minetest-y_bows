local s = y_bows.settings

function y_bows.shoot(entity_name, shooter, weapon, projectile)
	if minetest.get_item_group(weapon:get_name(), "y_bows_weapon") == 0 then
		return
	end
	local weapon_def = weapon:get_definition()
	if minetest.get_item_group(projectile:get_name(), weapon_def._y_bows_projectile_group) == 0 then
		return
	end
	local shooter_meta = shooter:get_meta()
	local draw_time = weapon_def._y_bows_draw_time
	local drawing_elapsed = shooter_meta:get_float("y_bows:drawing_elapsed")
	if drawing_elapsed < draw_time / 2 then
		return
	end

	local base_speed = weapon_def._y_bows_base_speed
	local crit_chance = weapon_def._y_bows_crit_chance
	local speed = base_speed * math.min(drawing_elapsed, draw_time) / draw_time
	local projectile_def = projectile:get_definition()
	local parameters = table.copy(projectile_def._y_bows_parameters)
	local crit
	if parameters.punch then
		parameters.punch.scale_speed = s.base_speed

		local damage_groups = (parameters.punch.tool_capabilities or {}).damage_groups
		local crit_check = 100 * math.random()
		crit = damage_groups and crit_chance >= crit_check
		if crit then
			for damage_group, value in pairs(damage_groups) do
				damage_groups[damage_group] = 2 * value
			end
			-- TODO: change particles and sounds?
		end
	end
	shooter_meta:set_float("y_bows:drawing_elapsed", 0)
	local obj =
		ballistics.player_shoots(entity_name, shooter, speed, nil, parameters, projectile_def._y_bows_properties)
	if obj then
		if crit then
			minetest.sound_play({ name = "y_bows_bow_shoot_crit" }, { pos = obj:get_pos() }, true)
		else
			minetest.sound_play({ name = "y_bows_bow_shoot" }, { pos = obj:get_pos() }, true)
		end
	end
	return obj
end
