(define (problem problema)
	(:domain dnd)
	(:objects
		pedro - player
		carlota - cleric
		maria - mage
		orc - melee_enemy
		long_sword, axe, mace, dagger - meleew
		bow - rangedw
		heavy_armor, medium_armor - armor
		t00 t01 t02 t10 t11 t12 t20 t21 t22 - tile
	)

	(:init
		(= (damage long_sword) 8)
		(= (damage axe) 6)
		(= (damage mace) 6)
		(= (damage dagger) 4)

		(= (protection heavy_armor) 3)
		(= (protection medium_armor) 2)

		(= (x t00) 0) (= (y t00) 0)(= (x t01) 0) (= (y t01) 1)(= (x t02) 0) (= (y t02) 2)(= (x t10) 1) (= (y t10) 0)(= (x t11) 1) (= (y t11) 1)(= (x t12) 1) (= (y t12) 2)(= (x t20) 2) (= (y t20) 0)(= (x t21) 2) (= (y t21) 1)(= (x t22) 2) (= (y t22) 2)
		(= (total-cost) 0)

		(= (hp orc) 30)
		(= (initiative orc) 2)
		(= (action orc) 1)
		(= (base_action orc) 1)
		(= (movement orc) 6)
		(= (base_movement orc) 6)
		(on orc t00)
		(has orc axe)	
		(has orc medium_armor)	
		(last_hit orc pedro)

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

		(= (max_turn) 4)
		(= (turn) 4)

	)
	(:goal (<= (hp orc) 0))
	(:metric minimize (total-cost))
)