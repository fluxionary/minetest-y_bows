local craftitems = {}

if y_bows.has.basic_materials then
	craftitems.oil = "basic_materials:oil_extract"
	craftitems.steel_wire = "basic_materials:steel_wire"
else
	craftitems.oil = "group:food_oil"
end

if y_bows.has.default then
	craftitems.bronze = "default:bronze_ingot"
	craftitems.cobble = "group:cobble"
	craftitems.diamond = "default:diamond"
	craftitems.flint = "default:flint"
	craftitems.mese_crystal = "default:mese_crystal"
	craftitems.steel = "default:steel_ingot"
	craftitems.stick = "group:stick"
	craftitems.stone = "group:stone"
	craftitems.torch = "default:torch"
	craftitems.mese = "default:mese_crystal"
	craftitems.wood = "group:wood"

	craftitems.target_face = "default:mese_crystal"
end

if y_bows.has.farming then
	craftitems.target_core = "farming:straw"
	craftitems.string = "farming:string"
end

if y_bows.has.fire then
	craftitems.fire = "fire:basic_flame"
end

if y_bows.has.animalia or y_bows.has.mobs_animals or y_bows.has.petz then
	craftitems.feather = "group:feather"
elseif y_bows.has.wool then
	craftitems.feather = "group:wool"
end

y_bows.resources.craftitems = craftitems
