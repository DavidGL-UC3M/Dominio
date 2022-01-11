(define (problem problema)
	(:domain dnd)
	(:objects
		bob - mage
		orc - melee_enemy
		club - meleew
		bow - rangedw
		leather_armor - armor
		t00 t01 t02 t10 t11 t12 t20 t21 t22 - tile
	)

	(:init
		(= (damage club) 5)

		(= (protection leather_armor) 1)

		(= (effective_range bow) 6)
		(= (x t00) 0) (= (y t00) 0)(= (x t01) 0) (= (y t01) 1)(= (x t02) 0) (= (y t02) 2)(= (x t10) 1) (= (y t10) 0)(= (x t11) 1) (= (y t11) 1)(= (x t12) 1) (= (y t12) 2)(= (x t20) 2) (= (y t20) 0)(= (x t21) 2) (= (y t21) 1)(= (x t22) 2) (= (y t22) 2)
		(= (hp_lost) 0)

		(= (hp orc) 35)
		(= (initiative orc) 2)
		(= (action orc) 1)
		(= (base_action orc) 1)
		(= (movement orc) 6)
		(= (base_movement orc) 6)
		(on orc t00)
		(has orc club)		
		(last_hit orc bob)

		(= (hp bob) 50)
		(= (initiative bob) 1)
		(= (action bob) 1)
		(= (base_action bob) 1)
		(= (movement bob) 6)
		(= (base_movement bob) 6)
		(on bob t22)
		(= (mana bob) 2)

		(= (max_turn) 2)
		(= (turn) 2)

	)
	(:goal
		(<= (hp orc) 0)
	)
	(:metric minimize (hp_lost))
)