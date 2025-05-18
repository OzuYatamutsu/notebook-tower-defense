class_name Laser
extends Projectile

func _ready() -> void:
    self.SPEED = 1000.0
    self.DAMAGE = 1.0

func _process(_delta) -> void:
    if !IS_ACTIVE:
        return

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
