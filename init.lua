ballistics.check_version({ year = 2024, month = 1, day = 10 })

y_bows = fmod.create()

y_bows.dofile("util")

y_bows.dofile("resources", "init")

y_bows.dofile("projectile_entities")
y_bows.dofile("shoot")

y_bows.dofile("weapon")
y_bows.dofile("bows")
y_bows.dofile("slingshots")

y_bows.dofile("ammo")
y_bows.dofile("arrows")
y_bows.dofile("slingshot_ammo")

y_bows.dofile("track_drawing")
y_bows.dofile("hud")

y_bows.dofile("target")

y_bows.dofile("compat", "init")
