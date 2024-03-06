if not y_bows.has.cucina_vegana then
	return
end

local def = minetest.registered_items["cucina_vegana:tomato"]
if not def then
	return
end

y_bows.register_item_as_ammo("cucina_vegana:tomato", "y_bows_slingshot_ammo", {
	parameters = {
		drag = {
			coefficient = 0.6,
		},
		punch = {
			tool_capabilities = {
				damage_groups = { fleshy = 0 },
			},
		},
		hit_sound = {
			spec = {
				name = "y_bows_splat",
			},
		},
	},
	properties = {
		textures = { rawget(def, "wield_image") or def.inventory_image },
		collisionbox = { -0.2, -0.2, -0.2, 0.2, 0.2, 0.2 },
	},
})
