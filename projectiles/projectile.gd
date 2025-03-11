class_name Projectile
extends StaticBody2D

@export var DESPAWN_TIMER_SECS = 5.0
@export var SPEED = 300.0
@export var TARGET: Mob
@export var TARGET_LOCATION: Vector2

@onready var DespawnTimer = $DespawnTimer

func init(target_location: Vector2) -> void:
    # Note: need to rework this!
    # I shouldn't route towards a static position; I should route towards the enemy's position (homing)
    position = get_parent().position
    TARGET_LOCATION = target_location
    DespawnTimer.wait_time = DESPAWN_TIMER_SECS
    DespawnTimer.start()

func _process(delta: float) -> void:
    position = Vector2(
        move_toward(position.x, TARGET_LOCATION.x, SPEED * delta),
        move_toward(position.y, TARGET_LOCATION.y, SPEED * delta),
    )

func _on_despawn_timer_timeout() -> void:
    queue_free()
