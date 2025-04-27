class_name SlowTower
extends Tower

func _init() -> void:
    VALUE = 200
    super._init()

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/Slow.tscn"),
        2000.00,
        0.75
    )

    # TODO
    enable()
