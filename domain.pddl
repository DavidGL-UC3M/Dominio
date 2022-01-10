(define (domain dnd)
  (:requirements :strips :typing :fluents)
  
  (:types
    tile entity - object
    player enemy - entity
    mage barbarian ranger cleric - player
    orc goblin skeleton_warrior skeleton_archer - enemy
    )
  (:functions
    (hp-lost)
    (distance ?t1 - tile ?t2 - tile)
    (hp ?e - entity)
    )
  (:predicates
    (on ?e - entity ?t - tile)
    )
  (:action NAME
  :parameters ()
  :precondition ()
  :effect ()
  )
 
)