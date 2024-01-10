if not y_bows.has.mesecons then
	return
end

minetest.override_item("y_bows:target", {
	mesecons = { receptor = { state = "off" } },
	on_timer = function(pos, elapsed)
		mesecon.receptor_off(pos)
		return false
	end,
})

y_bows.register_on_bullseye_hit(function(pos, player)
	mesecon.receptor_on(pos)
	minetest.get_node_timer(pos):start(2)
end)
