class_name PoisonSpikeTower
extends SpikeTower

func _init() -> void:
    VALUE = 750
    Description = (
        "COST: {0} MONEY\n".format([VALUE]) +
        "\n" +
        "Tower which sprays poison spikes on the ground at the " +
        "start of each wave. Poison spikes deal constant damage " +
        "over time to a monster.\n" +
        "\n"
    )
    IsUpgraded = true
    UpgradeEffects = [
        "+POISON",
        "+SLOW",
        "--DAMAGE"
    ]
    for effect in UpgradeEffects:
        Description += effect + "\n"
    self._superinit()

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
