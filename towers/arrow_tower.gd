class_name ArrowTower
extends Tower

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/Arrow.tscn"),
        2000.00,
        1.0
    )

    # TODO
    enable()
