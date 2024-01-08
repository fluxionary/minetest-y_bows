local f = string.format

local s = y_bows.settings

y_bows.util = {}

function y_bows.util.register_craft_if_valid(name, recipe)
	local recipe_is_valid = true
	if type(recipe) == "table" and #recipe > 0 and type(recipe[1]) == "table" and #recipe[1] > 0 then
		local width = #recipe[1]
		for i = 1, #recipe do
			local row = recipe[i]
			if #row ~= width then
				recipe_is_valid = false
				break
			end
			for j = 1, #row do
				if type(row[j]) ~= "string" then
					recipe_is_valid = false
					break
				else
					local mod, item = row[j]:split(":")
					if mod == "group" and #futil.get_items_with_group(item) == 0 then
						recipe_is_valid = false
						break
					elseif not minetest.registered_items[row[j]] then
						recipe_is_valid = false
						break
					end
				end
			end
			if not recipe_is_valid then
				break
			end
		end
	else
		recipe_is_valid = false
	end

	if recipe_is_valid then
		craftsystem.register_craft({
			output = f("%s %s", name, s.arrows_per_craft),
			type = "shaped",
			recipe = recipe,
		})
	end
end
