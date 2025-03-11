class_name Projectile
extends StaticBody2D

@export var DESPAWN_TIMER_SECS = 10.0
@export var SPEED = 300.0
@export var TARGET: Mob
@export var TARGET_LOCATION: Vector2
@export var IS_ACTIVE = false

@onready var DespawnTimer = $DespawnTimer

func fire_at(target: Mob) -> void:
    TARGET = target
    update_target_position()
    DespawnTimer.wait_time = DESPAWN_TIMER_SECS
    DespawnTimer.start()
    IS_ACTIVE = true
    
func update_target_position():
    if TARGET == null:
        return
    TARGET_LOCATION = TARGET.global_position

func _process(delta: float) -> void:
    if !IS_ACTIVE:
        return

    global_position += Vector2(
        move_toward(global_position.x, TARGET_LOCATION.x, SPEED * delta),
        move_toward(global_position.y, TARGET_LOCATION.y, SPEED * delta),
    )

func _on_despawn_timer_timeout() -> void:
    # We didn't hit the target in time
    # so clean this up
    queue_free()
