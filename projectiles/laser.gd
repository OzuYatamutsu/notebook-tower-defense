class_name Laser
extends Projectile

const DAMAGE_EVERY_SECS: float = 0.01

@onready var DamageEveryTimer: Timer = $DamageEveryTimer

func _ready() -> void:
    self.SPEED = 1000.0
    self.DAMAGE = 1.0
    
    DamageEveryTimer.wait_time = DAMAGE_EVERY_SECS
    DamageEveryTimer.start()

func _process(_delta) -> void:
    if !IS_ACTIVE:
        return
    _despawn_if_target_destroyed()

    if TARGET:
        direction = (
            TARGET.global_position - global_position
        ).normalized()

        scale.x = (
            TARGET.global_position - global_position
        ).length()
        rotation = direction.angle()

func fire_at(target: Mob) -> void:
    assert(SPEED != 0.0, "Projectiles must have a speed set!")

    TARGET = target
    DespawnTimer.wait_time = DESPAWN_TIMER_SECS
    DespawnTimer.start()
    IS_ACTIVE = true

    direction = (
        TARGET.global_position - global_position
    ).normalized()

func _on_damage_tick():
    if not TARGET:
        return
    print("Laser: damage tick")
    TARGET.HEALTH_BAR.damage_by(self.DAMAGE)
    _despawn_if_target_destroyed()

func _despawn_if_target_destroyed():
    if not TARGET:
        queue_free()
