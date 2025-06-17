class_name HeavyLaserTower
extends Tower

const RETARGETING_PERIOD_SECS = 1.0

@onready var RetargetingTimer = $RetargetingTimer

var IS_ACTIVELY_FIRING: bool = false

func _init() -> void:
    VALUE = 800
    IsUpgraded = true
    UpgradeEffects = [
        "+Targets strongest",
        "+DAMAGE",
        "+RANGE",
        "-SPEED"
    ]
    super._init()

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/HeavyLaser.tscn"),
        1500.00,  # Range
        3.0  # Rate of fire
    )
    
    RetargetingTimer.wait_time = RETARGETING_PERIOD_SECS
    RetargetingTimer.start()
    enable()

func retarget() -> void:
    if TargetingQueue.is_empty():
        return

    TargetingQueue.append(CURRENT_TARGET)
    CURRENT_TARGET = null
    
    TargetingQueue.sort_custom(_sort_mobs_by_hp)
    CURRENT_TARGET = TargetingQueue.pop_front()
    ShouldFireImmediately = true

func fire() -> void:
    if IS_ACTIVELY_FIRING:
        return
    super.fire()
    IS_ACTIVELY_FIRING = true

func _on_targeting_radius_exited(body: Mob) -> void:
    super._on_targeting_radius_exited(body)
    IS_ACTIVELY_FIRING = false

func _sort_mobs_by_hp(mob1: Mob, mob2: Mob) -> bool:
    return mob1.HEALTH_BAR.HP > mob2.HEALTH_BAR.HP

func _on_retargeting_timer_timeout() -> void:
    retarget()
