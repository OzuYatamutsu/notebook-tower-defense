extends Node

const LEVEL_HITBOX_GROUP = "level_hitbox"
const MOBS_GROUP = "mobs"
const TOWERS_GROUP = "towers"
const PROJECTILES_GROUP = "projectiles"

@export var PLAYER_LIVES_START: int
@export var PLAYER_LIVES_REMAINING: int

func _on_level_load() -> void:
    # Call this as a last step after the level is loaded
    PLAYER_LIVES_REMAINING = PLAYER_LIVES_START

    var hitbox: LevelHitbox = get_tree().get_first_node_in_group(LEVEL_HITBOX_GROUP)
    hitbox.connect(hitbox.mob_slipped_through.get_name(), _on_mob_slipped_through)

    assert(PLAYER_LIVES_REMAINING > 0, "Lives left on level start should be > 0!")
    assert(get_tree().get_first_node_in_group(GameState.MOBS_GROUP), "Missing a mobs node!")
    assert(get_tree().get_first_node_in_group(GameState.TOWERS_GROUP), "Missing a towers node!")
    assert(get_tree().get_first_node_in_group(GameState.PROJECTILES_GROUP), "Missing a projectiles node!")

func _on_mob_slipped_through() -> void:
    PLAYER_LIVES_REMAINING -= 1
    print(
        "Took damage! Remaining health: " 
        + str(PLAYER_LIVES_REMAINING)
    )

    if PLAYER_LIVES_REMAINING <= 0:
        _on_no_lives_remaining()

func _on_no_lives_remaining() -> void:
    get_tree().quit()  # TODO
