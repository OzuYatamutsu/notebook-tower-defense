class_name SniperTower
extends Tower

func _init() -> void:
    VALUE = 500
    IsUpgraded = true
    UpgradeEffects = [
        "+DAMAGE",
        "+SPEED",
        "+RANGE",
        "-FIRE RATE"
    ]

    super._init()

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/SniperBullet.tscn"),
        4000.0,
        3.50
    )

    enable()
