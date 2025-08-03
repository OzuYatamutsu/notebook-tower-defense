class_name SpikeTower
extends Tower

var NUM_MINES: int = 10

func _init() -> void:
    VALUE = 500
    Description = (
        "COST: {0} MONEY\n".format([VALUE]) +
        "\n" +
        "Tower which sprays damaging spikes on the ground at the start of each wave.\n" +
        "\n" +
        "MEDIUM DAMAGE\n" +
        "NO SPECIAL EFFECTS\n" +
        "MEDIUM RANGE"
    )
    UpgradesTo = [
        "res://towers/MineTower.tscn",
        "res://towers/PoisonSpikeTower.tscn"
    ]
    IsUpgraded = false
    super._init()

func _superinit():
    super._init()

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/Spike.tscn"),
        250.0,
        60.0  # timer isn't used
    )

    GameState.CURRENT_LEVEL.CURRENT_WAVE_TIMER.timeout.connect(
        fire
    )

    enable()

func fire() -> void:
    for i in NUM_MINES:
        # Spawn a new projectile
        var new_mine: Mineable = PROJECTILE_REF.instantiate()
        ProjectileRoot.add_child(new_mine)
        new_mine.global_position = global_position

        # ...and fire it at a randomly generated position
        new_mine.TARGET_LOCATION = _get_random_non_wall_point_within_targeting_radius()
        new_mine.fire_mine()
        print(str(self) + ": Shooting at: " + str(new_mine.TARGET_LOCATION))

func enable() -> void:
    # Noop
    IS_ACTIVE = true

func disable() -> void:
    # Noop
    IS_ACTIVE = false

func _on_targeting_radius_entered(_body: Mob) -> void:
    pass  # noop

func _on_targeting_radius_exited(_body: Mob) -> void:
    pass  # noop

func _on_shoot_timer_timeout() -> void:
    pass  # noop
