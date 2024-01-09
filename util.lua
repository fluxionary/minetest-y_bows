local f = string.format

local s = y_bows.settings

y_bows.util = {}

local function recipe_is_valid(recipe)
	if type(recipe) == "table" and #recipe > 0 and type(recipe[1]) == "table" and #recipe[1] > 0 then
		local width = #recipe[1]
		for i = 1, #recipe do
			local row = recipe[i]
			if #row ~= width then
				return false
			end
			for j = 1, #row do
				if type(row[j]) ~= "string" then
					return false
				else
					local mod, item = row[j]:split(":")
					if mod == "group" and #futil.get_items_with_group(item) == 0 then
						return false
					elseif not minetest.registered_items[row[j]] then
						return false
					end
				end
			end
		end
	else
		return false
	end

	return true
end

function y_bows.util.register_craft_if_valid(name, recipe)
	if recipe_is_valid(recipe) then
		craftsystem.api.register_craft({
			output = f("%s %s", name, s.arrows_per_craft),
			type = "shaped",
			recipe = recipe,
		})
	end
end

function y_bows.util.find_in_inv(player, group)
	local inv = player:get_inventory()
	for i = 1, inv:get_size("main") do
		local stack = inv:get_stack("main", i)
		if minetest.get_item_group(stack:get_name(), group) > 0 then
			return i, stack
		end
	end
end
