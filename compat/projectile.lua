if not y_bows.settings.alias_projectile then
	return
end

minetest.register_alias("projectile:bow", "y_bows:bow_wood")
minetest.register_alias("projectile:steel_bow", "y_bows:bow_steel")

minetest.register_alias("projectile:arrow", "y_bows:arrow_steel")
minetest.register_alias("projectile:arrow_high_velocity", "y_bows:arrow_diamond")
minetest.register_alias("projectile:arrow_fire", "y_bows:arrow_fire")

minetest.register_alias("projectile:slingshot", "y_bows:slingshot_wood")
minetest.register_alias("projectile:steel_slingshot", "y_bows:slingshot_steel")
minetest.register_alias("projectile:rock", "y_bows:ball_rock")
