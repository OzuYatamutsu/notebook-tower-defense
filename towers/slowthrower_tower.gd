class_name SlowthrowerTower
extends Tower

const SPEED_THRESHOLD: float = 0.025

func _init() -> void:
    VALUE = 750
    Description = (
        "COST: {0} MONEY\n".format([VALUE]) +
        "\n" +
        "Tower which fires snowflakes at a target in a constant " +
        "stream, slowing them.\n" +
        "\n"
    )
    IsUpgraded = true
    UpgradeEffects = [
        "+RANGE",
        "++FIRE RATE",
        "-DAMAGE"
    ]
    for effect in UpgradeEffects:
        Description += effect + "\n"
    super._init()

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/Slowthrower.tscn"),
        1500.00,  # Range
        0.05  # Rate of fire
    )

    enable()

func fire() -> void:
    super.fire()

    if CURRENT_TARGET.SPEED <= SPEED_THRESHOLD:
        CURRENT_TARGET = null

        if !TargetingQueue.is_empty():
            retarget_if_able()

func retarget_if_able() -> void:
    for target in TargetingQueue:
        if target.SPEED > SPEED_THRESHOLD:
            CURRENT_TARGET = TargetingQueue.pop_front()
            break
