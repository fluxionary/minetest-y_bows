ballistics.register_projectile("y_bows:slingshot_ammo", {
	visual = "sprite",
	textures = { "y_bows_ball_rock.png" },
	collisionbox = { -0.2, -0.2, -0.2, 0.2, 0.2, 0.2 },
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
				name = "y_bows_wind",
			},
			parameters = {
				loop = true,
				max_hear_distance = 64,
				pitch = 8,
				gain = 0.125,
			},
		},
		hit_sound = {
			spec = {
				name = "y_bows_arrow_hit",
			},
		},
	},

	on_activate = function(self, ...)
		if self._parameters.active_sound then
			ballistics.on_activate_active_sound_play(self, ...)
		end
	end,
	on_deactivate = function(self, ...)
		if self._parameters.active_sound then
			ballistics.on_deactivate_active_sound_stop(self, ...)
		end
	end,
	on_step = function(self, ...)
		if self._parameters.drag then
			ballistics.on_step_apply_drag(self, ...)
		end
		if self._parameters.particles then
			ballistics.on_step_particles(self, ...)
		end
	end,

	on_hit_node = function(self, pos, node, axis, old_velocity, new_velocity)
		ballistics.on_hit_node_freeze(self, pos, node, axis, old_velocity, new_velocity)
		if self._parameters.active_sound then
			ballistics.on_hit_node_active_sound_stop(self, pos, node, axis, old_velocity, new_velocity)
		end
		if self._parameters.hit_sound then
			ballistics.on_hit_node_hit_sound_play(self, pos, node, axis, old_velocity, new_velocity)
		end
		if self._parameters.replace then
			ballistics.on_hit_node_replace(self, pos, node, axis, old_velocity, new_velocity)
		end
		if self._parameters.remove_object then
			self.object:remove()
		end

		return true
	end,

	on_hit_object = function(self, object, axis, old_velocity, new_velocity)
		if self._parameters.active_sound then
			ballistics.on_hit_object_active_sound_stop(self)
		end
		if self._parameters.hit_sound then
			ballistics.on_hit_object_hit_sound_play(self, object, axis, old_velocity, new_velocity)
		end
		if self._parameters.punch then
			ballistics.on_hit_object_punch(self, object, axis, old_velocity, new_velocity)
		end
		if self._parameters.replace then
			ballistics.on_hit_object_replace(self, object, axis, old_velocity, new_velocity)
		end
		if minetest.is_player(self._source_obj) then
			minetest.sound_play(
				{ name = "y_bows_arrow_successful_hit" },
				{ to_player = self._source_obj:get_player_name() }
			)
		end
		if self._parameters.remove_object then
			self.object:remove()
		end

		-- TODO: when i get the "attach to entity" thing working, do that here
		self.object:remove()

		return true
	end,

	on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
		if self._parameters.drop_item then
			if ballistics.on_punch_drop_item(self, puncher, time_from_last_punch, tool_capabilities, dir, damage) then
				return
			end
		end
		ballistics.on_punch_deflect(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
	end,
})