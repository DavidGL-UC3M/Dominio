(define (problem problema)
	(:domain dnd)
	(:objects
		pedro - player
		orc - melee_enemy
		goblin1, goblin2 - ranged_enemy
		long_sword, axe - meleew
		bow - rangedw
		heavy_armor, leather_armor, medium_armor - armor
		t00 t01 t02 t03 t04 t05 t10 t11 t12 t13 t14 t15 t20 t21 t22 t23 t24 t25 t30 t31 t32 t33 t34 t35 t40 t41 t42 t43 t44 t45 t50 t51 t52 t53 t54 t55 - tile
	)

	(:init
		(= (damage long_sword) 8)
		(= (damage axe) 6)
		(= (damage bow) 7)
		(= (effective_range bow) 6)

		(= (protection heavy_armor) 3)
		(= (protection medium_armor) 2)
		(= (protection leather_armor) 1)

		(= (x t00) 0) (= (y t00) 0)(= (x t01) 0) (= (y t01) 1)(= (x t02) 0) (= (y t02) 2)(= (x t03) 0) (= (y t03) 3)(= (x t04) 0) (= (y t04) 4)(= (x t05) 0) (= (y t05) 5)(= (x t10) 1) (= (y t10) 0)(= (x t11) 1) (= (y t11) 1)(= (x t12) 1) (= (y t12) 2)(= (x t13) 1) (= (y t13) 3)(= (x t14) 1) (= (y t14) 4)(= (x t15) 1) (= (y t15) 5)(= (x t20) 2) (= (y t20) 0)(= (x t21) 2) (= (y t21) 1)(= (x t22) 2) (= (y t22) 2)(= (x t23) 2) (= (y t23) 3)(= (x t24) 2) (= (y t24) 4)(= (x t25) 2) (= (y t25) 5)(= (x t30) 3) (= (y t30) 0)(= (x t31) 3) (= (y t31) 1)(= (x t32) 3) (= (y t32) 2)(= (x t33) 3) (= (y t33) 3)(= (x t34) 3) (= (y t34) 4)(= (x t35) 3) (= (y t35) 5)(= (x t40) 4) (= (y t40) 0)(= (x t41) 4) (= (y t41) 1)(= (x t42) 4) (= (y t42) 2)(= (x t43) 4) (= (y t43) 3)(= (x t44) 4) (= (y t44) 4)(= (x t45) 4) (= (y t45) 5)(= (x t50) 5) (= (y t50) 0)(= (x t51) 5) (= (y t51) 1)(= (x t52) 5) (= (y t52) 2)(= (x t53) 5) (= (y t53) 3)(= (x t54) 5) (= (y t54) 4)(= (x t55) 5) (= (y t55) 5)
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
		(on pedro t45)
		(has pedro heavy_armor)
		(has pedro long_sword)

		(= (max_turn) 4)
		(= (turn) 4)

	)
	(:goal (and (<= (hp orc) 0) (<= (hp goblin1) 0) (<= (hp goblin2) 0)))
	;(:goal (<= (hp orc) 0))
	(:metric minimize (total-cost))
)