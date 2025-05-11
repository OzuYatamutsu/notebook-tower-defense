class_name Projectile
extends Area2D

@export var DESPAWN_TIMER_SECS = 10.0
@export var SPEED: float
@export var TARGET: Mob
@export var IS_ACTIVE = false
@export var DAMAGE: float
var EFFECTS: Array[Effect]
var AVERAGE_DELTA: float

@onready var DespawnTimer = $DespawnTimer

var direction: Vector2 = Vector2.ZERO

func _init():
    self.collision_layer = 0x8  # projectiles
    self.collision_mask = 0x4  # mobs

func fire(at_direction: Vector2) -> void:
    assert(SPEED != 0.0, "Projectiles must have a speed set!")
    
    DespawnTimer.wait_time = DESPAWN_TIMER_SECS
    DespawnTimer.start()
    IS_ACTIVE = true
    
    direction = at_direction

func fire_at(target: Mob) -> void:
    assert(SPEED != 0.0, "Projectiles must have a speed set!")

    TARGET = target
    DespawnTimer.wait_time = DESPAWN_TIMER_SECS
    DespawnTimer.start()
    IS_ACTIVE = true
    
    var maybe_pather = target.get_parent()
    if maybe_pather is MobPather:
        return _fire_at_target_leading(maybe_pather)
    
    # Otherwise, just fire at the mob's current position
    direction = (
        TARGET.global_position - global_position
    ).normalized()

func _fire_at_target_leading(pather: MobPather) -> void:
    var path: Path2D = pather.get_parent()

    var time_to_hit: float = (
        TARGET.global_position.distance_to(global_position)
        / (SPEED * GameState.AVG_FRAME_TIME)
    )

    var predicted_future_progress_ratio: float = (
        pather.progress_ratio
        + (TARGET.SPEED * GameState.AVG_FRAME_TIME * time_to_hit)
    )

    var predicted_future_position: Vector2 = path.to_global(
        path.curve.sample_baked(
            path.curve.get_baked_length()
            * predicted_future_progress_ratio
        )
    )

    direction = (
        predicted_future_position - global_position
    ).normalized()

func has_unapplied_effect() -> bool:
    return EFFECTS != null and !EFFECTS.is_empty()

func pop_next_effect() -> Effect:
    return EFFECTS.pop_front()

func _process(delta: float) -> void:
    if !IS_ACTIVE:
        return

    global_position += direction * SPEED * delta

func _on_despawn_timer_timeout() -> void:
    # We didn't hit the target in time
    # so clean this up
    queue_free()
