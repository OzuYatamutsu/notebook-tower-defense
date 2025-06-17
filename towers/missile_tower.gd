class_name MissileTower
extends Tower

func _init() -> void:
    VALUE = 750
    IsUpgraded = true
    UpgradeEffects = [
        "+DAMAGE",
        "+SPLASH DAMAGE",
        "-FIRE RATE",
        "-SPEED"
    ]
    super._init()

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/Missile.tscn"),
        1000.00,  # Range
        1.5  # Rate of fire
    )

    enable()
