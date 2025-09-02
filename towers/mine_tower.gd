class_name MineTower
extends SpikeTower

func _init() -> void:
    VALUE = 1500
    Description = (
        "COST: {0} MONEY\n".format([VALUE]) +
        "\n" +
        "Tower which sprays exploding mines on the ground at the " +
        "start of each wave. Exploding mines deal damage to nearby " +
        "monsters.\n" +
        "\n"
    )
    IsUpgraded = true
    UpgradeEffects = [
        "+SPLASH DAMAGE",
        "-DAMAGE",
        "-MINES"
    ]
    for effect in UpgradeEffects:
        Description += effect + "\n"
    NUM_MINES = 7
    self._superinit()

func _ready() -> void:
    ready_tower(
        Mine,
        250.0,
        60.0  # timer isn't used
    )

    GameState.CURRENT_LEVEL.CURRENT_WAVE_TIMER.timeout.connect(
        fire
    )

    enable()
