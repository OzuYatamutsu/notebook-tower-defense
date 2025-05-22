class_name SniperTower
extends Tower

func _init() -> void:
    VALUE = 500
    IsUpgraded = true
    UpgradeEffects = [
        "+DAMAGE",
        "+SPEED",
        "-FIRE RATE"
    ]

    super._init()

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/Bullet.tscn"),
        2000.00,
        1.0
    )

    enable()
