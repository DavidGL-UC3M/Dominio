(define (problem problema)
	(:domain dnd)
	(:objects
		pedro - player
		orc - melee_enemy
		goblin1, goblin2 - ranged_enemy
		long_sword, axe - meleew
		bow - rangedw
		heavy_armor, leather_armor, medium_armor - armor
		t00 t01 t02 t10 t11 t12 t20 t21 t22 - tile
	)

	(:init
		(= (damage long_sword) 8)
		(= (damage axe) 6)
		(= (damage bow) 7)
		(= (effective_range bow) 6)

		(= (protection heavy_armor) 3)
		(= (protection medium_armor) 2)
		(= (protection leather_armor) 1)

		(= (x t00) 0) (= (y t00) 0)(= (x t01) 0) (= (y t01) 1)(= (x t02) 0) (= (y t02) 2)(= (x t10) 1) (= (y t10) 0)(= (x t11) 1) (= (y t11) 1)(= (x t12) 1) (= (y t12) 2)(= (x t20) 2) (= (y t20) 0)(= (x t21) 2) (= (y t21) 1)(= (x t22) 2) (= (y t22) 2)
		(= (total-cost) 0)

		(= (hp orc) 30)
		(= (initiative orc) 2)
		(= (action orc) 1)
		(= (base_action orc) 1)
		(= (movement orc) 6)
		(= (base_movement orc) 6)
		(on orc t11)
		(has orc axe)	
		(has orc medium_armor)	
		(last_hit orc pedro)

		(= (hp goblin1) 15)
		(= (initiative goblin1) 3)
		(= (action goblin1) 1)
		(= (base_action goblin1) 1)
		(= (movement goblin1) 6)
		(= (base_movement goblin1) 6)
		(on goblin1 t01)
		(has goblin1 bow)	
		(has goblin1 leather_armor)	
		(last_hit goblin1 pedro)

		(= (hp goblin2) 15)
		(= (initiative goblin2) 4)
		(= (action goblin2) 1)
		(= (base_action goblin2) 1)
		(= (movement goblin2) 6)
		(= (base_movement goblin2) 6)
		(on goblin2 t10)
		(has goblin2 bow)	
		(has goblin2 leather_armor)	
		(last_hit goblin2 pedro)

		(= (hp pedro) 50)
		(= (initiative pedro) 1)
		(= (action pedro) 1)
		(= (base_action pedro) 1)
		(= (movement pedro) 6)
		(= (base_movement pedro) 6)
		(on pedro t22)
		(has pedro heavy_armor)
		(has pedro long_sword)

		(= (max_turn) 4)
		(= (turn) 4)

	)
	(:goal (and (<= (hp orc) 0) (<= (hp goblin1) 0) (<= (hp goblin2) 0)))
	;(:goal (<= (hp orc) 0))
	(:metric minimize (total-cost))
)