class_name LevelHitbox
extends Area2D

signal mob_slipped_through(Mob)

func _ready() -> void:
    # On level load, register hits to the global hitbox
    add_to_group(GameState.LEVEL_HITBOX_GROUP)

func _on_area_entered(mob: Mob) -> void:
    print(str(mob) + " slipped through!")
    emit_signal("mob_slipped_through", mob)
