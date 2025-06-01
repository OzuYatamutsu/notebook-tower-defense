class_name MineTower
extends Tower

func _init() -> void:
    VALUE = 500
    IsUpgraded = true
    UpgradeEffects = [
        "+SPLASH DAMAGE",
        "-DAMAGE",
        "-MINES"
    ]

    super._init()

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/Mine.tscn"),
        4000.0,
        3.50
    )

    enable()
