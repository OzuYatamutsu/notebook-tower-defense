extends Node

const LEVEL_HITBOX_GROUP = "level_hitbox"

@export var PLAYER_LIVES_START: int
@export var PLAYER_LIVES_REMAINING: int

func _on_level_load() -> void:
    # Call this as a last step after the level is loaded
    PLAYER_LIVES_REMAINING = PLAYER_LIVES_START

    var hitbox: LevelHitbox = get_tree().get_first_node_in_group(LEVEL_HITBOX_GROUP)
    hitbox.connect(hitbox.mob_slipped_through.get_name(), _on_mob_slipped_through)
    assert(PLAYER_LIVES_REMAINING > 0, "Lives left on level start should be > 0!")

func _on_mob_slipped_through() -> void:
    PLAYER_LIVES_REMAINING -= 1
    print(
        "Took damage! Remaining health: " 
        + str(PLAYER_LIVES_REMAINING)
    )

    if PLAYER_LIVES_REMAINING <= 0:
        _on_no_lives_remaining()

func _on_no_lives_remaining():
    get_tree().quit()  # TODO
