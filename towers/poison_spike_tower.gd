class_name PoisonSpikeTower
extends Tower

func _init() -> void:
    VALUE = 500
    IsUpgraded = true
    UpgradeEffects = [
        "+POISON",
        "+SLOW",
        "--DAMAGE"
    ]

    super._init()

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/PoisonSpike.tscn"),
        4000.0,
        3.50
    )

    enable()
