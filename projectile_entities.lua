local registered_projectiles = {}

local base_def = {
	immortal = true,

	parameters = {
		particles = {
			amount = 1,
			time = 0.1,
			texture = "y_bows_arrow_particle.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 8,
				aspect_h = 8,
				length = 1,
			},
			glow = 1,
			minvel = { x = 0, y = -0.1, z = 0 },
			maxvel = { x = 0, y = -0.1, z = 0 },
			minacc = { x = 0, y = -0.1, z = 0 },
			maxacc = { x = 0, y = -0.1, z = 0 },
			minexptime = 0.5,
			maxexptime = 0.5,
			minsize = 2,
			maxsize = 2,
			_period = 0.09,
		},
		active_sound = {
			spec = {
				name = "y_bows_wind_high",
			},
			parameters = {
				loop = true,
				max_hear_distance = 64,
				--pitch = 8,
				gain = 0.125,
			},
		},
		hit_sound = {
			spec = {
				name = "y_bows_arrow_hit",
			},
		},
		time_to_live = y_bows.settings.time_to_live,
	},

	on_activate = function(self, ...)
		ballistics.on_activate_active_sound_play(self, ...)
	end,

	on_deactivate = function(self, ...)
		ballistics.on_deactivate_active_sound_stop(self, ...)
	end,

	on_step = function(self, ...)
		if ballistics.on_step_check_time_to_live(self, ...) then
			return true
		end
		ballistics.on_step_particles(self, ...)
		if self._parameters.drag then
			ballistics.on_step_apply_drag(self, ...)
		end
	end,

	on_hit_node = function(self, node_pos, node, ...)
		ballistics.on_hit_node_attach(self, node_pos, node, ...)
		ballistics.on_hit_node_active_sound_stop(self, node_pos, node, ...)
		ballistics.on_hit_node_hit_sound_play(self, node_pos, node, ...)

		if self._parameters.replace then
			ballistics.on_hit_node_replace(self, node_pos, node, ...)
		end

		if y_bows.util.bullseye_was_hit(self, node_pos, node, ...) then
			y_bows.on_bullseye_hit(node_pos, self._source_obj)
		end

		if self._parameters.remove_object then
			self.object:remove()
		end

		return true
	end,

	on_hit_object = function(self, object, ...)
		local hit_a_projectile = false
		local entity = object:get_luaentity()
		if entity and registered_projectiles[entity.name] then
			hit_a_projectile = true
		end

		ballistics.on_hit_object_active_sound_stop(self)
		if not hit_a_projectile then
			ballistics.on_hit_object_hit_sound_play(self, object, ...)
		end

		if self._parameters.punch then
			ballistics.on_hit_object_punch(self, object, ...)
		end

		local source = self._source_obj
		if minetest.is_player(source) and not hit_a_projectile then
			minetest.sound_play({ name = "y_bows_arrow_successful_hit" }, { to_player = source:get_player_name() })
		end

		if self._parameters.remove_object then
			self.object:remove()
		elseif hit_a_projectile then
			if self._parameters.add_item then
				ballistics.on_hit_object_add_item(self)
			end
			if entity._parameters.add_item then
				ballistics.on_hit_object_add_item(entity)
			end
		end

		if self._parameters.replace then
			ballistics.on_hit_object_replace(self, object, ...)
		end

		-- TODO: when i get the "attach to entity" thing working, do that here
		self.object:remove()

		return true
	end,

	on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
		if self._parameters.pickup_item then
			if ballistics.on_punch_pickup_item(self, puncher, time_from_last_punch, tool_capabilities, dir, damage) then
				return
			end
		elseif self._parameters.add_item then
			if ballistics.on_punch_add_item(self, puncher, time_from_last_punch, tool_capabilities, dir, damage) then
				return
			end
		end
		ballistics.on_punch_deflect(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
	end,
}

function y_bows.register_projectile(name, overrides)
	local def = table.copy(base_def)
	futil.table.set_all(def, overrides)
	ballistics.register_projectile(name, def)
	registered_projectiles[name] = true
end

y_bows.register_projectile("y_bows:arrow", {
	is_arrow = true,
	update_period = 0.25,
	visual = "mesh",
	mesh = "y_bows_arrow.b3d",
	textures = { "y_bows_arrow_mesh.png" },
	collisionbox = { -0.05, -0.05, -0.05, 0.05, 0.05, 0.05 },
	selectionbox = { -0.05, -0.05, -0.2, 0.05, 0.05, 0.2, rotate = true },
})

y_bows.register_projectile("y_bows:slingshot_ammo", {
	visual = "sprite",
	textures = { "y_bows_ball_rock.png" },
	collisionbox = { -0.05, -0.05, -0.05, 0.05, 0.05, 0.05 },
	visual_size = vector.new(0.2, 0.2, 0.2),
})
