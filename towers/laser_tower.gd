class_name LaserTower
extends Tower

var IS_ACTIVELY_FIRING: bool = false

func _init() -> void:
    VALUE = 750
    UpgradesTo = [
        "res://towers/HeavyLaserTower.tscn",
        "res://towers/FastLaserTower.tscn"
    ]
    IsUpgraded = false
    super._init()

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/Laser.tscn"),
        1000.00,  # Range
        2.5  # Rate of fire
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
