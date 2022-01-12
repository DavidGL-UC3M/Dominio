(define (domain dnd)
	(:requirements :typing :fluents :negative-preconditions :disjunctive-preconditions)
	(:types
		tile entity equipment - object
		; tipo de equipamiento
		weapon armor - equipment
		meleew rangedw - weapon
		player enemy - entity
		; Tipos de entidades
		mage cleric - player
		melee_enemy ranged_enemy - enemy
	)
	(:predicates
		(on ?e - entity ?t - tile)
		(has ?e - entity ?eq - equipment)
		(last_hit ?e - enemy ?p - player)
	)
	(:functions
		(total-cost)
		(turn)
		(max_turn)
		(x ?t - tile)
		(y ?t - tile)
		(hp ?e - entity)
		(initiative ?e - entity)
		(movement ?e - entity)
		(base_movement ?e - entity)
		(action ?e - entity)
		(base_action ?e - entity)
		(mana ?p - player)
		(damage ?w - weapon)
		(effective_range ?rw - rangedw)
		(protection ?a - armor)
	)

	;
	; MOVIMIENTO
	;
	(:action move
		:parameters (?e1 - player ?t1 ?t2 - tile)
		:precondition (and
			(> (hp ?e1) 0)
			(= (initiative ?e1) (turn))
			(> (movement ?e1) 0)
			(not (exists
					(?e2 - entity)
					(or
						(on ?e2 ?t2)
						(> (hp ?e2) 0)
					)
				)
			)
			(on ?e1 ?t1)
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
		)
		:effect (and
			(decrease (movement ?e1) 1)
			(not (on ?e1 ?t1))
			(on ?e1 ?t2)
			(increase (total-cost) 1)
		)
	)

	  (:action dash
		:parameters (?e1 - player)
		:precondition (and
			(> (hp ?e1) 0)
			(= (initiative ?e1) (turn))
			(> (action ?e1) 0)
		)
		:effect (and
			(decrease (action ?e1) 1)
			(increase (movement ?e1) (base_movement ?e1))
			(increase (total-cost) 1)
		)
	)

	;
	; Magia
	;
	(:action heal
		:parameters (?e1 - cleric ?e2 - player ?t1 ?t2 - tile)
		:precondition (and
			(> (hp ?e1) 0)
			(= (initiative ?e1) (turn))
			(> (action ?e1) 0)
			(> (mana ?e1) 0)
			(on ?e1 ?t1)
			(on ?e2 ?t2)
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
		)

		:effect (and
			(decrease (action ?e1) 1)
			(decrease (mana ?e1) 1)
			(increase (hp ?e2) 12)
			(decrease (total-cost) 11)
		)
	)
	(:action Magic_Missile
		:parameters (?p - mage ?e1 ?e2 ?e3 - enemy ?t1 ?t2 ?t3 ?t4 - tile)
		:precondition (and
			(> (hp ?p) 0)
			(= (initiative ?p) (turn))
			(> (action ?p) 0)
			(> (mana ?p) 0)
			(on ?p ?t1)
			(on ?e1 ?t2)
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 576)
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 576)
			(on ?e2 ?t3)
			(<= (* (- (x ?t1) (x ?t3)) (- (x ?t1) (x ?t3))) 576)
			(<= (* (- (y ?t1) (y ?t3)) (- (y ?t1) (y ?t3))) 576)
			(on ?e3 ?t4)
			(<= (* (- (x ?t1) (x ?t4)) (- (x ?t1) (x ?t4))) 576)
			(<= (* (- (y ?t1) (y ?t4)) (- (y ?t1) (y ?t4))) 576)
			(or
				(> (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
				(> (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
			)
			(or
				(> (* (- (x ?t1) (x ?t3)) (- (x ?t1) (x ?t3))) 1)
				(> (* (- (y ?t1) (y ?t3)) (- (y ?t1) (y ?t3))) 1)
			)			
			(or
				(> (* (- (x ?t1) (x ?t4)) (- (x ?t1) (x ?t4))) 1)
				(> (* (- (y ?t1) (y ?t4)) (- (y ?t1) (y ?t4))) 1)
			)
		)

		:effect (and
			(decrease (action ?p) 1)
			(decrease (mana ?p) 1)
			(decrease (hp ?e1) 3)
			(decrease (hp ?e2) 3)
			(decrease (hp ?e3) 3)
			(increase (total-cost) 1)
			(forall
				(?p2 - player)
				(not (last_hit ?e1 ?p2)))
			(last_hit ?e1 ?p)
			(forall
				(?p2 - player)
				(not (last_hit ?e2 ?p2)))
			(last_hit ?e2 ?p)
			(forall
				(?p2 - player)
				(not (last_hit ?e3 ?p2)))
			(last_hit ?e3 ?p)
		)
	)
	(:action Fire_bolt
		:parameters (?p - mage ?e1 - enemy ?t1 ?t2 - tile ?a - armor)
		:precondition (and
			(> (hp ?p) 0)
			(= (initiative ?p) (turn))
			(> (action ?p) 0)
			(on ?p ?t1)
			(on ?e1 ?t2)
			(has ?e1 ?a)
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 576)
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 576)
			(or
				(> (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
				(> (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
			)
		)

		:effect (and
			(decrease (action ?p) 1)
			(decrease (hp ?e1) (- (protection ?a) 5))
			(increase (total-cost) 1)
			(forall
				(?p2 - player)
				(not (last_hit ?e1 ?p2)))
			(last_hit ?e1 ?p)
		)
	)
	(:action Fire_bolt_no_armor
		:parameters (?p - mage ?e1 - enemy ?t1 ?t2 - tile)
		:precondition (and
			(> (hp ?p) 0)
			(= (initiative ?p) (turn))
			(> (action ?p) 0)
			(on ?p ?t1)
			(on ?e1 ?t2)	
			(not (exists (?a - armor) (has ?e1 ?a)))
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 576)
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 576)
			(or
				(> (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
				(> (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
			)
		)

		:effect (and
			(decrease (action ?p) 1)
			(decrease (hp ?e1)  5)
			(increase (total-cost) 1)
			(forall
				(?p2 - player)
				(not (last_hit ?e1 ?p2)))
			(last_hit ?e1 ?p)
		)
	)
	(:action Shocking_grasp
		:parameters (?p - mage ?e1 - enemy ?t1 ?t2 - tile)
		:precondition (and
			(> (hp ?p) 0)
			(= (initiative ?p) (turn))
			(> (action ?p) 0)
			(on ?p ?t1)
			(on ?e1 ?t2)	
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
		)

		:effect (and
			(decrease (action ?p) 1)
			(decrease (hp ?e1)  4)
			(increase (total-cost) 1)
			(forall
				(?p2 - player)
				(not (last_hit ?e1 ?p2)))
			(last_hit ?e1 ?p)
		)
	)
	;
	; ataques
	;
	(:action unnarmed_attack_no_armor
		:parameters (?p - player ?e - enemy ?t1 ?t2 - tile)
		:precondition (and
			(> (hp ?p) 0)
			(= (initiative ?p) (turn))
			(> (action ?p) 0)
			(on ?p ?t1)
			(on ?e ?t2)
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
			(not (exists (?a - armor) (has ?e ?a)))
		)

		:effect (and
			(decrease (action ?p) 1)
			(decrease (hp ?e) 1)
			(forall
				(?p2 - player)
				(not (last_hit ?e ?p2)))
			(last_hit ?e ?p)
			(increase (total-cost) 1)
		)
	)

	(:action unnarmed_attack
		:parameters (?p - player ?e - enemy ?t1 ?t2 - tile ?a - armor)
		:precondition (and
			(> (hp ?p) 0)
			(= (initiative ?p) (turn))
			(> (action ?p) 0)
			(on ?p ?t1)
			(on ?e ?t2)
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
			(has ?e ?a)
		)

		:effect (and
			(decrease (action ?p) 1)
			(forall
				(?p2 - player)
				(not (last_hit ?e ?p2)))
			(last_hit ?e ?p)
			(increase (total-cost) 1)
		)
	)

	(:action melee_attack
		:parameters (?p - player ?e - enemy ?w - meleew ?t1 ?t2 - tile ?a - armor)
		:precondition (and
			(> (hp ?p) 0)
			(= (initiative ?p) (turn))
			(> (action ?p) 0)
			(on ?p ?t1)
			(on ?e ?t2)
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
			(has ?p ?w)
			(has ?e ?a)
		)

		:effect (and
			(decrease (action ?p) 1)
			(decrease (hp ?e) (- (damage ?w) (protection ?a)))
			(forall
				(?p2 - player)
				(not (last_hit ?e ?p2)))
			(last_hit ?e ?p)
			(increase (total-cost) 1)
		)
	)

	(:action melee_attack_no_armor
		:parameters (?p - player ?e - enemy ?w - meleew ?t1 ?t2 - tile )
		:precondition (and
			(> (hp ?p) 0)
			(= (initiative ?p) (turn))
			(> (action ?p) 0)
			(on ?p ?t1)
			(on ?e ?t2)
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
			(has ?p ?w)
			(not (exists (?a - armor) (has ?e ?a)))
		)

		:effect (and
			(decrease (action ?p) 1)
			(decrease (hp ?e) (damage ?w))
			(forall
				(?p2 - player)
				(not (last_hit ?e ?p2)))
			(last_hit ?e ?p)
			(increase (total-cost) 1)
		)
	)

	(:action ranged_attack
		:parameters (?p - player ?e - enemy ?w - rangedw ?t1 ?t2 - tile ?a - armor)
		:precondition (and
			(> (hp ?p) 0)
			(= (initiative ?p) (turn))
			(> (action ?p) 0)
			(on ?p ?t1)
			(on ?e ?t2)
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) (* (effective_range ?w) (effective_range ?w)))
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) (* (effective_range ?w) (effective_range ?w)))
			(or
				(> (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
				(> (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
			)
			(has ?p ?w)
		)

		:effect (and
			(decrease (action ?p) 1)
			(decrease (hp ?e) (- (damage ?w) (protection ?a)))
			(forall
				(?p2 - player)
				(not (last_hit ?e ?p2)))
			(last_hit ?e ?p)
			(increase (total-cost) 1)
		)
	)

	(:action ranged_attack_no_armor
		:parameters (?p - player ?e - enemy ?w - rangedw ?t1 ?t2 - tile)
		:precondition (and
			(> (hp ?p) 0)
			(= (initiative ?p) (turn))
			(> (action ?p) 0)
			(on ?p ?t1)
			(on ?e ?t2)
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) (* (effective_range ?w) (effective_range ?w)))
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) (* (effective_range ?w) (effective_range ?w)))
			(or
				(> (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
				(> (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
			)
			(has ?p ?w)
			(not (exists (?a - armor) (has ?e ?a)))
		)

		:effect (and
			(decrease (action ?p) 1)
			(decrease (hp ?e) (damage ?w))
			(forall
				(?p2 - player)
				(not (last_hit ?e ?p2)))
			(last_hit ?e ?p)
			(increase (total-cost) 1)
		)
	)
	;
	; TERMINAR TURNO
	;
	(:action end_turn_enemy;
		:parameters (?e - enemy)
		:precondition (and
			(= (initiative ?e) (turn))
			(= (action ?e) 0)
		)
		:effect (and
			(decrease (turn) 1)
			(assign (movement ?e) (base_movement ?e))
			(assign (action ?e) (base_action ?e))
			(increase (total-cost) 1)
		)
	)
	(:action end_turn;
		:parameters (?e - player)
		:precondition (= (initiative ?e) (turn))
		:effect (and
			(decrease (turn) 1)
			(assign (movement ?e) (base_movement ?e))
			(assign (action ?e) (base_action ?e))
			(increase (total-cost) 1)
		)
	)
	(:action end_round;
		:parameters ()
		:precondition (= (turn) 0)
		:effect (and
			(assign (turn) (max_turn))
			(increase (total-cost) 1)			
			)
	)
	;
	;  Ranged enemy
	;
	(:action move_ranged_enemy
		:parameters (?e1 - ranged_enemy ?p - player ?t1 ?t2 - tile)
		:precondition (and
			(> (hp ?e1) 0)
			(= (initiative ?e1) (turn))
			(> (movement ?e1) 0)
			(not (exists
					(?e2 - entity)
					(on ?e2 ?t2)))
			(on ?e1 ?t1)
			; tile is within 1 position in x and y
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
			(last_hit ?e1 ?p)
			; tile is further away in at least one coordinate to all players

			(exists (?tp - tile)
				(and
					(on ?p ?tp)
					(or
						(and 
							(< (* (- (x ?t1) (x ?tp)) (- (x ?t1) (x ?tp))) (* (- (x ?t2) (x ?tp)) (- (x ?t2) (x ?tp))))
							(= (* (- (y ?t1) (y ?tp)) (- (y ?t1) (y ?tp))) (* (- (y ?t2) (y ?tp)) (- (y ?t2) (y ?tp))))
						
						)
						(and 
							(= (* (- (x ?t1) (x ?tp)) (- (x ?t1) (x ?tp))) (* (- (x ?t2) (x ?tp)) (- (x ?t2) (x ?tp))))
							(< (* (- (y ?t1) (y ?tp)) (- (y ?t1) (y ?tp))) (* (- (y ?t2) (y ?tp)) (- (y ?t2) (y ?tp))))
						
						)
					)
				)
			)
		)
		:effect (and
			(decrease (movement ?e1) 1)
			(not (on ?e1 ?t1))
			(on ?e1 ?t2)
			(increase (total-cost) 1)
		)
	)

	(:action ranged_attack_enemy
		:parameters (?e1 - ranged_enemy ?e2 - player ?w - rangedw ?t1 ?t2 - tile ?a - armor)
		:precondition (and
			(> (hp ?e1) 0)
			(= (initiative ?e1) (turn))
			(> (action ?e1) 0)
			(last_hit ?e1 ?e2)

			(on ?e1 ?t1)
			(on ?e2 ?t2)
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) (* (effective_range ?w) (effective_range ?w)))
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) (* (effective_range ?w) (effective_range ?w)))
			(or
				(> (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
				(> (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
			)
			(has ?e1 ?w)
			(has ?e2 ?a)
		)

		:effect (and
			(decrease (action ?e1) 1)
			(decrease (hp ?e2) (- (damage ?w) (protection ?a)))
			(increase (total-cost) (- (damage ?w) (protection ?a)))
			(increase (total-cost) 1)
		)
	)
	(:action ranged_attack_enemy_no_armor
		:parameters (?e1 - ranged_enemy ?e2 - player ?w - rangedw ?t1 ?t2 - tile)
		:precondition (and
			(> (hp ?e1) 0)
			(= (initiative ?e1) (turn))
			(> (action ?e1) 0)
			(last_hit ?e1 ?e2)

			(on ?e1 ?t1)
			(on ?e2 ?t2)
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) (* (effective_range ?w) (effective_range ?w)))
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) (* (effective_range ?w) (effective_range ?w)))
			(or
				(> (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
				(> (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
			)
			(has ?e1 ?w)
			(not (exists (?a - armor) (has ?e2 ?a)))
		)

		:effect (and
			(decrease (action ?e1) 1)
			(decrease (hp ?e2) (damage ?w))
			(increase (total-cost) (damage ?w))
			(increase (total-cost) 1)
		)
	)
	;
	; Melee enemy
	;
	(:action move_melee_enemy
		:parameters (?e1 - melee_enemy ?p - player ?t1 ?t2 - tile)
		:precondition (and
			(> (hp ?e1) 0)
			(= (initiative ?e1) (turn))
			(> (movement ?e1) 0)
			(not (exists
					(?e2 - entity)
					(on ?e2 ?t2)))
			(on ?e1 ?t1)
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
			(last_hit ?e1 ?p)
			; tile is further away in at least one coordinate to all players

			(exists (?tp - tile)
				(and
					(on ?p ?tp)
					(or
						(and 
							(> (* (- (x ?t1) (x ?tp)) (- (x ?t1) (x ?tp))) (* (- (x ?t2) (x ?tp)) (- (x ?t2) (x ?tp))))
							(= (* (- (y ?t1) (y ?tp)) (- (y ?t1) (y ?tp))) (* (- (y ?t2) (y ?tp)) (- (y ?t2) (y ?tp))))
						
						)
						(and 
							(= (* (- (x ?t1) (x ?tp)) (- (x ?t1) (x ?tp))) (* (- (x ?t2) (x ?tp)) (- (x ?t2) (x ?tp))))
							(> (* (- (y ?t1) (y ?tp)) (- (y ?t1) (y ?tp))) (* (- (y ?t2) (y ?tp)) (- (y ?t2) (y ?tp))))
						
						)
					)
				)
			)
		)
		:effect (and
			(decrease (movement ?e1) 1)
			(not (on ?e1 ?t1))
			(on ?e1 ?t2)
			(increase (total-cost) 1)
		)
	)

	(:action melee_attack_enemy
		:parameters (?p - melee_enemy ?e - player ?w - meleew ?t1 ?t2 - tile ?a - armor)
		:precondition (and
			(> (hp ?p) 0)
			(= (initiative ?p) (turn))
			(> (action ?p) 0)
			(on ?p ?t1)
			(on ?e ?t2)
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
			(has ?p ?w)
			(has ?e ?a)
		)

		:effect (and
			(decrease (action ?p) 1)
			(decrease (hp ?e) (- (damage ?w) (protection ?a)))
			(increase (total-cost) (- (damage ?w) (protection ?a)))
			(increase (total-cost) 1)
		)
	)

	(:action melee_attack_enemy_no_armor
		:parameters (?p - melee_enemy ?e - player ?w - meleew ?t1 ?t2 - tile )
		:precondition (and
			(> (hp ?p) 0)
			(= (initiative ?p) (turn))
			(> (action ?p) 0)
			(on ?p ?t1)
			(on ?e ?t2)
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
			(has ?p ?w)
			(not (exists (?a - armor) (has ?e ?a)))
		)

		:effect (and
			(decrease (action ?p) 1)
			(decrease (hp ?e) (damage ?w))
			(increase  (total-cost) (damage ?w))
			(increase (total-cost) 1)
		)
	)
)
