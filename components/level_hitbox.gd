class_name LevelHitbox
extends Area2D

signal mob_slipped_through

func _ready() -> void:
    # On level load, register hits to the global hitbox
    get_tree().current_scene.add_to_group(
        GameState.LEVEL_HITBOX_GROUP
    )

func _on_body_entered(body: Mob) -> void:
    print(str(body) + " slipped through!")
    emit_signal("mob_slipped_through")
