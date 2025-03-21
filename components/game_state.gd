extends Node

const LEVEL_HITBOX_GROUP = "level_hitbox"

@export var PLAYER_LIVES_START: int
@export var PLAYER_LIVES_REMAINING: int

func _on_level_load() -> void:
    # Call this as a last step after the level is loaded
    var hitbox: LevelHitbox = get_tree().get_first_node_in_group(LEVEL_HITBOX_GROUP)
    hitbox.connect(str(hitbox.mob_slipped_through), _on_mob_slipped_through)

func _on_mob_slipped_through() -> void:
    PLAYER_LIVES_REMAINING -= 1
    print("Took damage! Remaming health: %s", PLAYER_LIVES_REMAINING)

    if PLAYER_LIVES_REMAINING <= 0:
        _on_no_lives_remaining()

func _on_no_lives_remaining():
    get_tree().quit()  # TODO
