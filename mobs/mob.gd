class_name Mob
extends CharacterBody2D

@export var HP: float
@export var SPEED: float

func _physics_process(delta: float) -> void:
    velocity = get_next_direction() * delta * SPEED
    move_and_slide()

func get_next_direction() -> Vector2:
    # TODO for now just goes from left to right
    var direction = Vector2(1, 0)

    return direction
