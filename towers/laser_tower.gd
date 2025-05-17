class_name LaserTower
extends Tower

func _init() -> void:
    VALUE = 200
    super._init()

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/Laser.tscn"),
        2000.00,
        3.5
    )

    enable()

func fire() -> void:
    pass  # TODO
