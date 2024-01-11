local f = string.format

local S = y_bows.S

function y_bows.register_projectile(name, projectile_group, def)
	local parameters = table.copy(def.parameters or {})
	parameters.pickup_item = { item = name }

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
		groups = { [projectile_group] = 1 },
		light_source = def.light_source,
		_y_bows_parameters = parameters,
		_y_bows_properties = def.properties,
	})

	y_bows.util.register_craft_if_valid(name, def.recipe)
end
