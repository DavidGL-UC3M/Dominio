(define (problem problema)
	(:domain dnd)
	(:objects
		bob - cleric
		g - goblin
		sword - meleew
		bow - rangedw
		t00 t01 t02 t10 t11 t12 t20 t21 t22 - tile
	)

	(:init
		(= (damage sword) 2)
		(= (damage bow) 3)
		(= (effective_range bow) 6)
		(= (x t00) 0) (= (y t00) 0)(= (x t01) 0) (= (y t01) 1)(= (x t02) 0) (= (y t02) 2)(= (x t10) 1) (= (y t10) 0)(= (x t11) 1) (= (y t11) 1)(= (x t12) 1) (= (y t12) 2)(= (x t20) 2) (= (y t20) 0)(= (x t21) 2) (= (y t21) 1)(= (x t22) 2) (= (y t22) 2)
		(= (hp_lost) 0)

		(= (hp g) 4)
		(= (initiative g) 2)
		(= (action g) 1)
		(= (base_action g) 1)
		(= (movement g) 6)
		(= (base_movement g) 6)
		(on g t00)
		(has g bow)
		(last_hit g bob)

		(= (hp bob) 4)
		(= (initiative bob) 1)
		(= (action bob) 1)
		(= (base_action bob) 1)
		(= (movement bob) 6)
		(= (base_movement bob) 6)
		(on bob t22)
		(has bob sword)
		(= (mana bob) 5)

		(= (max_turn) 2)
		(= (turn) 2)

	)
	(:goal
		(<= (hp g) 0)
	)
	(:metric maximize (hp_lost))
)