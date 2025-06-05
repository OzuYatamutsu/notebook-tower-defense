class_name MineTower
extends SpikeTower

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
        250.0,
        60.0  # timer isn't used
    )

    GameState.CURRENT_LEVEL.CURRENT_WAVE_TIMER.timeout.connect(
        fire
    )

    enable()
