class_name Mineable
extends Area2D

# (i.e., a thing which acts like a mine)
# (the ones that explode. not a, like, coal mine)

@export var IS_ACTIVE = false
@export var DAMAGE: float
var EFFECTS: Array[Effect]

func _init():
    self.collision_layer = 0x8  # projectiles
    self.collision_mask = 0x4  # mobs
    area_entered.connect(_on_hit_mob)

func has_unapplied_effect() -> bool:
    return EFFECTS != null and !EFFECTS.is_empty()

func pop_next_effect() -> Effect:
    return EFFECTS.pop_front()

func _on_despawn_timer_timeout() -> void:
    # We didn't hit the target in time
    # so clean this up
    queue_free()

func _on_hit_mob(mob: Mob) -> void:
    # Collisions with mobs are handled
    # in the mob collision handler
    if !IS_ACTIVE:
        return
    queue_free()
