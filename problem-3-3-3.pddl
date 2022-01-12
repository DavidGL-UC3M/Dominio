(define (problem problema)
	(:domain dnd)
	(:objects
		pedro - player
		carlota - cleric
		maria - mage
		orc - melee_enemy
		goblin1, goblin2 - ranged_enemy
		long_sword, axe, mace dagger - meleew
		bow - rangedw
		heavy_armor, leather_armor, medium_armor - armor
		t00 t01 t02 t10 t11 t12 t20 t21 t22 - tile
	)

	(:init
		(= (damage long_sword) 8)
		(= (damage axe) 6)
		(= (damage bow) 7)
		(= (damage mace) 6)
		(= (damage dagger) 4)
		(= (effective_range bow) 6)

		(= (protection heavy_armor) 3)
		(= (protection medium_armor) 2)
		(= (protection leather_armor) 1)

		(= (x t00) 0) (= (y t00) 0)(= (x t01) 0) (= (y t01) 1)(= (x t02) 0) (= (y t02) 2)(= (x t10) 1) (= (y t10) 0)(= (x t11) 1) (= (y t11) 1)(= (x t12) 1) (= (y t12) 2)(= (x t20) 2) (= (y t20) 0)(= (x t21) 2) (= (y t21) 1)(= (x t22) 2) (= (y t22) 2)
		(= (total-cost) 0)

		(= (hp orc) 50)
		(= (initiative orc) 2)
		(= (action orc) 1)
		(= (base_action orc) 1)
		(= (movement orc) 6)
		(= (base_movement orc) 6)
		(on orc t00)
		(has orc axe)	
		(has orc medium_armor)	
		(last_hit orc pedro)

		(= (hp goblin1) 5)
		(= (initiative goblin1) 6)
		(= (action goblin1) 1)
		(= (base_action goblin1) 1)
		(= (movement goblin1) 6)
		(= (base_movement goblin1) 6)
		(on goblin1 t01)
		(has goblin1 bow)	
		(has goblin1 leather_armor)	
		(last_hit goblin1 pedro)

		(= (hp goblin2) 5)
		(= (initiative goblin2) 5)
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

		(= (hp carlota) 40)
		(= (initiative carlota) 4)
		(= (action carlota) 1)
		(= (base_action carlota) 1)
		(= (movement carlota) 6)
		(= (base_movement carlota) 6)
		(on carlota t21)
		(has carlota medium_armor)
		(has carlota mace)
		(= (mana carlota) 3)

		(= (hp maria) 30)
		(= (initiative maria) 3)
		(= (action maria) 1)
		(= (base_action maria) 1)
		(= (movement maria) 6)
		(= (base_movement maria) 6)
		(on maria t12)
		(has maria dagger)
		(= (mana maria) 6)

		(= (max_turn) 6)
		(= (turn) 6)

	)
	(:goal (and (<= (hp orc) 0) (<= (hp goblin1) 0) (<= (hp goblin2) 0)))
;	(:goal (<= (hp orc) 0))
	(:metric minimize (total-cost))
)