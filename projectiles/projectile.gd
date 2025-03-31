class_name Projectile
extends Area2D

@export var DESPAWN_TIMER_SECS = 10.0
@export var SPEED: float
@export var TARGET: Mob
@export var IS_ACTIVE = false
@export var DAMAGE: float

@onready var DespawnTimer = $DespawnTimer

var direction: Vector2 = Vector2.ZERO

func _init():
    self.collision_layer = 0x8  # projectiles
    self.collision_mask = 0x4  # mobs

func fire_at(target: Mob) -> void:
    assert(SPEED != 0.0, "Projectiles must have a speed set!")

    TARGET = target
    DespawnTimer.wait_time = DESPAWN_TIMER_SECS
    DespawnTimer.start()
    IS_ACTIVE = true

func _process(delta: float) -> void:
    if !IS_ACTIVE:
        return

    if TARGET == null:
        global_position = Vector2(
            move_toward(global_position.x, global_position.x + direction.x, SPEED * delta),
            move_toward(global_position.y, global_position.y + direction.y, SPEED * delta),
        )
    else:
        var target_position = Vector2(
            move_toward(global_position.x, TARGET.global_position.x, SPEED * delta),
            move_toward(global_position.y, TARGET.global_position.y, SPEED * delta),
        )
        direction = (target_position - global_position).normalized()
        global_position = target_position

func _on_despawn_timer_timeout() -> void:
    # We didn't hit the target in time
    # so clean this up
    queue_free()
