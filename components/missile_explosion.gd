class_name MissileExplosion
extends Area2D

const EXPLOSION_GROW_SPEED: float = 2500.0
const MAX_EXPLOSION_RADIUS: float = 750.0
const EXPLOSION_COLOR: Color = Color(1.0, 0.4, 0.4)
const DAMAGE: float = 50.0

var radius: float = 1.0

@onready var ExplosionCollider: CollisionShape2D = $ExplosionCollider

func _process(delta) -> void:
    radius += EXPLOSION_GROW_SPEED * delta
    if radius > MAX_EXPLOSION_RADIUS:
        _on_max_explosion_radius()
    queue_redraw()

func _on_max_explosion_radius() -> void:
    queue_free()

func _draw() -> void:
    draw_circle(global_position, radius, EXPLOSION_COLOR)
    ExplosionCollider.shape.radius = radius

func _on_area_entered(mob: Mob) -> void:
    mob.HEALTH_BAR.damage_by(DAMAGE)
