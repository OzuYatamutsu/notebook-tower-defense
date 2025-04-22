extends Node

const CURRENT_LEVEL_GROUP = "level"
const LEVEL_HITBOX_GROUP = "level_hitbox"
const MOBS_GROUP = "mobs"
const MOB_MEMBERS_GROUP = "mob_members"
const TOWERS_GROUP = "towers"
const PROJECTILES_GROUP = "projectiles"

const TOWER_PLACEMENT_SHADOW_GROUP = "tower_placement_shadow"
const MONEY_METER_GROUP = "money_meter"
const LIVES_METER_GROUP = "lives_meter"
const NEXT_WAVE_METER_GROUP = "next_wave_meter"
const SELECTED_TOWER_METER_GROUP = "selected_tower_meter"
const TOWER_BUY_PANEL_GROUP = "tower_buy_panel"

@export var PLAYER_LIVES_START: int
@export var PLAYER_LIVES_REMAINING: int
@export var PLAYER_MONEY_REMAINING: int
@export var SCORE: int
@export var IS_GAME_OVER: bool = false

var CURRENT_LEVEL: Level

var TOWER_PLACEMENT_SHADOW: TowerPlacementShadow
var MONEY_METER: MoneyMeter
var LIVES_METER: LivesMeter
var WAVE_METER: WaveMeter
var SELECTED_TOWER_METER: SelectedTowerMeter
var NEXT_WAVE_METER: NextWaveMeter
var TOWER_BUY_PANEL: TowerBuyPanel

var GAME_OVER_OVERLAY = load("res://levels/GameOver.tscn")
var WIN_OVERLAY = load("res://levels/Win.tscn")

func _on_level_load() -> void:
    # Call this as a last step after the level is loaded
    PLAYER_LIVES_REMAINING = PLAYER_LIVES_START

    var hitbox: LevelHitbox = get_tree().get_first_node_in_group(LEVEL_HITBOX_GROUP)
    hitbox.mob_slipped_through.connect(_on_mob_slipped_through)

    MONEY_METER = get_tree().get_first_node_in_group(MONEY_METER_GROUP)
    MONEY_METER.set_value(PLAYER_MONEY_REMAINING)
    
    LIVES_METER = get_tree().get_first_node_in_group(LIVES_METER_GROUP)
    LIVES_METER.set_value(PLAYER_LIVES_REMAINING)

    TOWER_PLACEMENT_SHADOW = get_tree().get_first_node_in_group(TOWER_PLACEMENT_SHADOW_GROUP)

    SELECTED_TOWER_METER = get_tree().get_first_node_in_group(SELECTED_TOWER_METER_GROUP)
    SELECTED_TOWER_METER.update_sprite()

    NEXT_WAVE_METER = get_tree().get_first_node_in_group(NEXT_WAVE_METER_GROUP)

    TOWER_BUY_PANEL = get_tree().get_first_node_in_group(TOWER_BUY_PANEL_GROUP)

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

func restart_game() -> void:
    IS_GAME_OVER = false
    get_tree().change_scene_to_file("res://levels/StartScreen.tscn")

func quit_game() -> void:
    get_tree().quit()

func _on_mob_slipped_through(mob: Mob) -> void:
    mob.delayed_despawn()

    if IS_GAME_OVER:
        return

    PLAYER_LIVES_REMAINING -= 1
    LIVES_METER.set_value(PLAYER_LIVES_REMAINING)
    print(
        "Took damage! Remaining health: " 
        + str(PLAYER_LIVES_REMAINING)
    )

    if PLAYER_LIVES_REMAINING <= 0:
        _on_no_lives_remaining()

func _on_no_lives_remaining() -> void:
    print("Lose...")

    IS_GAME_OVER = true
    TOWER_PLACEMENT_SHADOW.queue_free()

    var game_over_screen = GAME_OVER_OVERLAY.instantiate()
    CURRENT_LEVEL.get_node("UI").add_child(game_over_screen)
    CURRENT_LEVEL.get_node("UI").move_child(
        game_over_screen,
        0
    )

func _on_mob_despawn() -> void:
    var mob_count = get_tree().get_node_count_in_group(GameState.MOB_MEMBERS_GROUP)
    print(str(mob_count) + " mobs left in current wave!")

    if !CURRENT_LEVEL.WAITING_FOR_LAST_MOB_FLAG:
        return
    if mob_count == 0:
        _on_win()

func _on_win() -> void:
    if IS_GAME_OVER:
        return

    print("Win!")

    IS_GAME_OVER = true
    TOWER_PLACEMENT_SHADOW.queue_free()

    var win_screen = WIN_OVERLAY.instantiate()
    CURRENT_LEVEL.get_node("UI").add_child(win_screen)
    CURRENT_LEVEL.get_node("UI").move_child(
        win_screen,
        0
    )
