class_name HeavyLaserTower
extends Tower

func _init() -> void:
    VALUE = 500
    IsUpgraded = true
    UpgradeEffects = [
        "+Targets strongest",
        "+DAMAGE",
        "+RANGE",
        "-SPEED"
    ]
    super._init()

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/Laser.tscn"),
        1000.00,  # Range
        1.5  # Rate of fire
    )

    enable()
