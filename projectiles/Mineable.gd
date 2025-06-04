class_name Mineable
extends Projectile

# (i.e., a thing which acts like a mine)
# (the ones that explode. not a, like, coal mine)

@export var TARGET_LOCATION: Vector2

var IS_MOVING = false
var _target_direction: Vector2

func _init():
    self.collision_layer = 0x8  # projectiles
    self.collision_mask = 0x4  # mobs
    SPEED = 200.0
    IS_ACTIVE = false
    area_entered.connect(_on_hit_mob)

func _physics_process(delta: float) -> void:
    if !IS_MOVING:
        return

    global_position += _target_direction * SPEED * delta
    if _more_or_less_at_target_position():
        IS_MOVING = false
        IS_ACTIVE = true

func fire_mine() -> void:
    assert(TARGET_LOCATION != null)

    _target_direction = (
        TARGET_LOCATION - global_position
    ).normalized()

    IS_MOVING = true

func has_unapplied_effect() -> bool:
    return EFFECTS != null and !EFFECTS.is_empty()

func pop_next_effect() -> Effect:
    return EFFECTS.pop_front()

func _on_despawn_timer_timeout() -> void:
    # We didn't hit the target in time
    # so clean this up
    queue_free()

func _on_hit_mob(_mob: Mob) -> void:
    # Collisions with mobs are handled
    # in the mob collision handler
    if !IS_ACTIVE:
        return

func _more_or_less_at_target_position() -> bool:
    var relative_distance: float = (
        abs(global_position.x - TARGET_LOCATION.x)
        + abs(global_position.y - TARGET_LOCATION.y)
    )

    return (relative_distance < 10.0)
