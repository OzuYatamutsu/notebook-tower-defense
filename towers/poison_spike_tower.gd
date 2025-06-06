class_name PoisonSpikeTower
extends SpikeTower

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
        250.0,
        60.0  # timer isn't used
    )

    GameState.CURRENT_LEVEL.CURRENT_WAVE_TIMER.timeout.connect(
        fire
    )

    enable()
