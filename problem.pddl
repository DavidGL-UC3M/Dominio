(define (problem problema)
	(:domain dnd)
	(:objects
		bob - mage
		goblin - goblin
		sword - meleew
		bow - rangedw
		leather_armor - armor
		t00 t01 t02 t10 t11 t12 t20 t21 t22 - tile
	)

	(:init
		(= (damage sword) 2)
		(= (damage bow) 3)

		(= (protection leather_armor) 1)

		(= (effective_range bow) 6)
		(= (x t00) 0) (= (y t00) 0)(= (x t01) 0) (= (y t01) 1)(= (x t02) 0) (= (y t02) 2)(= (x t10) 1) (= (y t10) 0)(= (x t11) 1) (= (y t11) 1)(= (x t12) 1) (= (y t12) 2)(= (x t20) 2) (= (y t20) 0)(= (x t21) 2) (= (y t21) 1)(= (x t22) 2) (= (y t22) 2)
		(= (hp_lost) 0)

		(= (hp goblin) 15)
		(= (initiative goblin) 2)
		(= (action goblin) 1)
		(= (base_action goblin) 1)
		(= (movement goblin) 6)
		(= (base_movement goblin) 6)
		(on goblin t00)
		(has goblin bow)		
		(last_hit goblin bob)

		(= (hp bob) 50)
		(= (initiative bob) 1)
		(= (action bob) 1)
		(= (base_action bob) 1)
		(= (movement bob) 6)
		(= (base_movement bob) 6)
		(on bob t22)
		(has bob sword)
		(has bob leather_armor)
		(= (mana bob) 1)

		(= (max_turn) 2)
		(= (turn) 2)

	)
	(:goal
		(<= (hp goblin) 0)
	)
	(:metric minimize (hp_lost))
)