if not y_bows.settings.alias_bows then
	return
end

minetest.register_alias("bows:bow_wood", "y_bows:bow_wood")
minetest.register_alias("bows:bow_steel", "y_bows:bow_steel")
minetest.register_alias("bows:bow_bronze", "y_bows:bow_steel")
minetest.register_alias("bows:bow_bowie", "y_bows:bow_wood")

minetest.register_alias("bows:arrow", "y_bows:arrow_wood")
minetest.register_alias("bows:arrow_steel", "y_bows:arrow_steel")
minetest.register_alias("bows:arrow_mese", "y_bows:arrow_mese")
minetest.register_alias("bows:arrow_diamond", "y_bows:arrow_diamond")
