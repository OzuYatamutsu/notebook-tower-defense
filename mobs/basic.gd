class_name Basic
extends CharacterBody2D

@export var HP = 100.0
@export var SPEED = 200.0

func _physics_process(delta: float) -> void:
    velocity = get_next_direction() * SPEED
    move_and_slide()

func get_next_direction() -> Vector2:
    # TODO for now just goes from left to right
    var direction = Vector2(1, 0)

    return direction
