local f = string.format

local S = y_bows.S
local ci = y_bows.resources.craftitems

function y_bows.register_slingshot_ammo(name, def)
	local parameters = table.copy(def.parameters or {})
	parameters.drop_item = { item = name }

	local damage = 0
	for _, value in pairs(((parameters.punch or {}).tool_capabilities or {}).damage_groups or {}) do
		damage = damage + value
	end
	local drag = (parameters.drag or {}).coefficient or 0

	minetest.register_craftitem(name, {
		description = f(
			"%s\n%s\n%s",
			def.description,
			minetest.colorize("green", S("damage: @1", damage)),
			minetest.colorize("cyan", S("drag: @1", drag))
		),
		short_description = def.description,
		inventory_image = def.inventory_image,
		groups = { y_bows_slingshot_ammo = 1 },
		_ybows_parameters = parameters,
	})

	y_bows.util.register_craft_if_valid(name, def.recipe)
end

y_bows.register_slingshot_ammo("y_bows:ball_rock", {
	description = S("ball of rock"),
	inventory_image = "y_bows_ball_rock.png",
	recipe = { { ci.cobble }, { ci.cobble } },
	parameters = {
		drag = {
			coefficient = 0.3,
		},
		punch = {
			tool_capabilities = {
				damage_groups = { fleshy = 10 },
			},
		},
	},
})
