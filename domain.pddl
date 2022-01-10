(define (domain dnd)
	(:requirements :typing :fluents :negative-preconditions :disjunctive-preconditions :action-costs)
	(:types
		tile entity equipment - object
		; tipo de equipamiento
		;weapon armor - equipment
		weapon - equipment
		meleew rangedw - weapon
		player enemy - entity
		; Tipos de entidades
		mage barbarian ranger cleric - player
		orc goblin skeleton_warrior skeleton_archer - enemy
	)
	(:predicates
		(on ?e - entity ?t - tile)
		(has ?e - entity ?eq - equipment)
		(last_hit ?e - enemy ?p - player)
	)
	(:functions
		(hp_lost)
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
		(ammo ?w - rangedw)
		(effective_range ?rw - rangedw)
		;(protection ?a - armor)
	)

	;
	; MOVIMIENTO
	;
	(:action move
		:parameters (?e1 - entity ?t1 ?t2 - tile)
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
		)
		:effect (and
			(decrease (movement ?e1) 1)
			(not (on ?e1 ?t1))
			(on ?e1 ?t2)
		)
	)
	;
	; acciones
	;
	(:action heal
		:parameters (?e1 - cleric ?e2 - player ?t1 ?t2 - tile)
		:precondition (and
			(> (hp ?e1) 0)
			(= (initiative ?e1) (turn))
			(> (action ?e1) 0)
			(on ?e1 ?t1)
			(on ?e2 ?t2)
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
		)

		:effect (and
			(decrease (action ?e1) 1)
			(decrease (mana ?e1) 1)
			(increase (hp ?e2) 12)
			(increase (hp_lost) 12)
		)
	)
	(:action unnarmed_attack
		:parameters (?p - player ?e - enemy ?t1 ?t2 - tile)
		:precondition (and
			(> (hp ?p) 0)
			(= (initiative ?p) (turn))
			(> (action ?p) 0)
			(on ?p ?t1)
			(on ?e ?t2)
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
		)

		:effect (and
			(decrease (action ?p) 1)
			(decrease (hp ?e) 1)
			(forall
				(?p2 - player)
				(not (last_hit ?e ?p2)))
			(last_hit ?e ?p)
		)
	)

	(:action melee_attack
		:parameters (?p - player ?e - enemy ?w - meleew ?t1 ?t2 - tile)
		:precondition (and
			(> (hp ?p) 0)
			(= (initiative ?p) (turn))
			(> (action ?p) 0)
			(on ?p ?t1)
			(on ?e ?t2)
			(<= (* (- (x ?t1) (x ?t2)) (- (x ?t1) (x ?t2))) 1)
			(<= (* (- (y ?t1) (y ?t2)) (- (y ?t1) (y ?t2))) 1)
			(has ?p ?w)
		)

		:effect (and
			(decrease (action ?p) 1)
			(decrease (hp ?e) (damage ?w))
			(forall
				(?p2 - player)
				(not (last_hit ?e ?p2)))
			(last_hit ?e ?p)
		)
	)
	(:action ranged_attack
		:parameters (?p - player ?e - enemy ?w - rangedw ?t1 ?t2 - tile)
		:precondition (and
			(> (hp ?p) 0)
			(= (initiative ?p) (turn))
			(> (action ?p) 0)
			(> (ammo ?w) 0)
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
			(decrease (ammo ?w) 1)
			(decrease (hp ?e) (damage ?w))
			(forall
				(?p2 - player)
				(not (last_hit ?e ?p2)))
			(last_hit ?e ?p)
		)
	)
	;
	; TERMINAR TURNO
	;
	(:action end_turn;
		:parameters (?e - player)
		:precondition (= (initiative ?e) (turn))
		:effect (and
			(decrease (turn) 1)
			(assign (movement ?e) (base_movement ?e))
			(assign (action ?e) (base_action ?e))
		)
	)
	(:action end_round;
		:parameters ()
		:precondition (= (turn) 0)
		:effect (assign (turn) (max_turn))

	)
	;
	; GOBLIN
	;
	(:action end_turn_goblin;
		:parameters (?e - goblin)
		:precondition (and
			(= (initiative ?e) (turn))
			(= (action ?e) 0)
		)
		:effect (and
			(decrease (turn) 1)
			(assign (movement ?e) (base_movement ?e))
			(assign (action ?e) (base_action ?e))
		)
	)
	(:action ranged_attack_goblin
		:parameters (?e1 - goblin ?e2 - player ?w - rangedw ?t1 ?t2 - tile)
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
		)

		:effect (and
			(decrease (action ?e1) 1)
			(decrease (hp ?e2) (damage ?w))
			(decrease (hp_lost) (damage ?w))
		)
	)
)