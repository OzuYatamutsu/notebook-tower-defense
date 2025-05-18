class_name LaserTower
extends Tower

var IS_ACTIVELY_FIRING: bool = false

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
    if IS_ACTIVELY_FIRING:
        return
    super.fire()
    IS_ACTIVELY_FIRING = true

func _on_targeting_radius_exited(body: Mob) -> void:
    super._on_targeting_radius_exited(body)
    IS_ACTIVELY_FIRING = false
