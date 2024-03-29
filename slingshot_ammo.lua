local S = y_bows.S
local ci = y_bows.resources.craftitems

local damage_multiplier = y_bows.settings.damage_multiplier

function y_bows.register_slingshot_ammo(name, def)
	y_bows.register_ammo(name, "y_bows_slingshot_ammo", def)
end

y_bows.register_slingshot_ammo("y_bows:ball_rock", {
	description = S("ball of rock"),
	inventory_image = "y_bows_ball_rock.png",
	recipe = { { ci.cobble }, { ci.cobble } },
	parameters = {
		drag = {
			coefficient = 0.4,
		},
		punch = {
			tool_capabilities = {
				damage_groups = { fleshy = 2 * damage_multiplier },
			},
		},
	},
})
