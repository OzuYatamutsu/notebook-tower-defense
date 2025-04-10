extends Node

const CURRENT_LEVEL_GROUP = "level"
const LEVEL_HITBOX_GROUP = "level_hitbox"
const MOBS_GROUP = "mobs"
const TOWERS_GROUP = "towers"
const PROJECTILES_GROUP = "projectiles"

const MONEY_METER_GROUP = "money_meter"
const LIVES_METER_GROUP = "lives_meter"

@export var PLAYER_LIVES_START: int
@export var PLAYER_LIVES_REMAINING: int
@export var PLAYER_MONEY_REMAINING: int

var CURRENT_LEVEL: Level

var MONEY_METER: MoneyMeter
var LIVES_METER: LivesMeter
var WAVE_METER: WaveMeter

func _on_level_load() -> void:
    # Call this as a last step after the level is loaded
    PLAYER_LIVES_REMAINING = PLAYER_LIVES_START

    var hitbox: LevelHitbox = get_tree().get_first_node_in_group(LEVEL_HITBOX_GROUP)
    hitbox.mob_slipped_through.connect(_on_mob_slipped_through)

    MONEY_METER = get_tree().get_first_node_in_group(MONEY_METER_GROUP)
    MONEY_METER.set_value(PLAYER_MONEY_REMAINING)
    
    LIVES_METER = get_tree().get_first_node_in_group(LIVES_METER_GROUP)
    LIVES_METER.set_value(PLAYER_LIVES_REMAINING)

    assert(PLAYER_LIVES_REMAINING > 0, "Lives left on level start should be > 0!")
    assert(get_tree().get_first_node_in_group(GameState.MOBS_GROUP), "Missing a mobs node!")
    assert(get_tree().get_first_node_in_group(GameState.TOWERS_GROUP), "Missing a towers node!")
    assert(get_tree().get_first_node_in_group(GameState.PROJECTILES_GROUP), "Missing a projectiles node!")
    assert(CURRENT_LEVEL != null)

func add_money(value: int) -> void:
    PLAYER_MONEY_REMAINING += value
    MONEY_METER.set_value(PLAYER_MONEY_REMAINING)

func deduct_money(value: int) -> void:
    PLAYER_MONEY_REMAINING -= value
    if PLAYER_MONEY_REMAINING <= 0:
        PLAYER_MONEY_REMAINING = 0
    MONEY_METER.set_value(PLAYER_MONEY_REMAINING)

func _on_mob_killed() -> void:
    print(str(get_tree().get_node_count_in_group(GameState.MOBS_GROUP)) + " mobs left in current wave!")

func _on_mob_slipped_through() -> void:
    PLAYER_LIVES_REMAINING -= 1
    LIVES_METER.set_value(PLAYER_LIVES_REMAINING)
    print(
        "Took damage! Remaining health: " 
        + str(PLAYER_LIVES_REMAINING)
    )

    if PLAYER_LIVES_REMAINING <= 0:
        _on_no_lives_remaining()

func _on_no_lives_remaining() -> void:
    get_tree().quit()  # TODO
