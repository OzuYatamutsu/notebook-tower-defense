class_name ArrowTower
extends StaticBody2D

@export var PROJECTILE = ""
@export var CURRENT_TARGET: Basic
@export var RATE_OF_FIRE = 1.0

func _ready() -> void:
    # TODO
    # assert(PROJECTILE != null, "Towers need a projectile assigned!")
    pass

func _process(delta: float) -> void:
    pass

func _on_targeting_radius_entered(body: Basic) -> void:
    if CURRENT_TARGET == null:
        print(str(self) + ": Got a target, " + str(body))
        CURRENT_TARGET = body

func _on_targeting_radius_exited(body: Node2D) -> void:
    print(str(self) + ": Lost my target, " + str(body))
    CURRENT_TARGET = null
