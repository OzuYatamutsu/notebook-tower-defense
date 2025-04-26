class_name Projectile
extends Area2D

@export var DESPAWN_TIMER_SECS = 10.0
@export var SPEED: float
@export var TARGET: Mob
@export var IS_ACTIVE = false
@export var DAMAGE: float
var EFFECTS: Array[Effect]

@onready var DespawnTimer = $DespawnTimer

var direction: Vector2 = Vector2.ZERO

func _init():
    self.collision_layer = 0x8  # projectiles
    self.collision_mask = 0x4  # mobs

func fire_at(target: Mob) -> void:
    assert(SPEED != 0.0, "Projectiles must have a speed set!")

    TARGET = target
    direction = (TARGET.global_position - global_position).normalized()

    DespawnTimer.wait_time = DESPAWN_TIMER_SECS
    DespawnTimer.start()
    IS_ACTIVE = true

func has_unapplied_effect() -> bool:
    return EFFECTS != null and !EFFECTS.is_empty()

func pop_next_effect() -> Effect:
    return EFFECTS.pop_front()

func _process(delta: float) -> void:
    if !IS_ACTIVE:
        return

    global_position = Vector2(
        move_toward(global_position.x, global_position.x + direction.x, SPEED * delta),
        move_toward(global_position.y, global_position.y + direction.y, SPEED * delta),
    )

func _on_despawn_timer_timeout() -> void:
    # We didn't hit the target in time
    # so clean this up
    queue_free()
