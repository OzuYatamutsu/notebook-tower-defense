class_name SlowthrowerTower
extends Tower

const SPEED_THRESHOLD: float = 0.012

func _init() -> void:
    VALUE = 500
    IsUpgraded = true
    UpgradeEffects = [
        "+RANGE",
        "++FIRE RATE",
        "-DAMAGE"
    ]
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
