class_name Mob
extends CharacterBody2D

@export var HP: float
@export var SPEED: float
@onready var Hitbox = $Hitbox

func _ready() -> void:
    Hitbox.connect("body_entered", _on_hit)

func _physics_process(delta: float) -> void:
    velocity = get_next_direction() * delta * SPEED
    move_and_slide()

func get_next_direction() -> Vector2:
    # TODO for now just goes from left to right
    var direction = Vector2(1, 0)

    return direction

func _on_hit(projectile: Projectile) -> void:
    HP -= projectile.DAMAGE
    projectile.queue_free()

    if (HP <= 0.0):
        _on_death()

func _on_death():
    queue_free()
