# GlobalSingleton: GameState
extends Node

const STARTING_WINDOW_SIZE_PERCENT = 0.65

const PLAYER_STARTING_MONEY: int = 3000
const PLAYER_MAX_MONEY = 9999
const CURRENT_LEVEL_GROUP = "level"
const LEVEL_HITBOX_GROUP = "level_hitbox"
const MOBS_GROUP = "mobs"
const MOB_MEMBERS_GROUP = "mob_members"
const TOWERS_GROUP = "towers"
const PROJECTILES_GROUP = "projectiles"
const WALLS_GROUP = "walls"

const TOWER_PLACEMENT_SHADOW_GROUP = "tower_placement_shadow"
const MONEY_METER_GROUP = "money_meter"
const LIVES_METER_GROUP = "lives_meter"
const NEXT_WAVE_METER_GROUP = "next_wave_meter"
const SELECTED_TOWER_METER_GROUP = "selected_tower_meter"
const TOWER_INFO_AND_BUY_PANEL_GROUP = "tower_info_and_buy_panel"
const TOWER_BUY_PANEL_GROUP = "tower_buy_panel"
const TOWER_UPGRADE_PANEL_GROUP = "tower_upgrade_panel"
const AUDIO_GROUP = "audio"

@export var PLAYER_LIVES_START: int = 20
@export var IS_GAME_OVER: bool = false
@export var SFX_ENABLED: bool = true
@export var BGM_ENABLED: bool = true

# Accessed via meters in UI
@export var PLAYER_MONEY_REMAINING: int = 3150
@export var PLAYER_LIVES_REMAINING: int
@export var SCORE: int
# WaveMeter is accessed through CurrentLevel -> CURRENT_WAVE_NUM

var CURRENT_LEVEL: Level

var TOWER_PLACEMENT_SHADOW: TowerPlacementShadow
var MONEY_METER: MoneyMeter
var LIVES_METER: LivesMeter
var WAVE_METER: WaveMeter
var SELECTED_TOWER_METER: SelectedTowerMeter
var NEXT_WAVE_METER: NextWaveMeter
var TOWER_BUY_PANEL: TowerBuyPanel
var TOWER_UPGRADE_PANEL: TowerUpgradePanel
var TOWER_INFO_AND_BUY_PANEL: TowerInfoAndBuyPanel
var AUDIO_CONTROL: Audio

var GAME_OVER_OVERLAY = load("res://levels/GameOver.tscn")
var WIN_OVERLAY = load("res://levels/Win.tscn")
var PAUSE_SCREEN: Control = preload("res://components/PauseScreen.tscn").instantiate()
var AVG_FRAME_TIME: float
var SHOULDNT_PAUSE: bool = false

func _init() -> void:
    process_mode = Node.PROCESS_MODE_ALWAYS

func _ready() -> void:
    # Expand window size dynamically
    if get_window().get_mode() != Window.Mode.MODE_FULLSCREEN:
        get_window().size = _get_target_init_window_size()
        get_window().position = (
            DisplayServer.screen_get_size() - get_window().size
        ) / 2

func _on_level_load() -> void:
    # Call this as a last step after the level is loaded
    PLAYER_LIVES_REMAINING = PLAYER_LIVES_START

    var hitbox: LevelHitbox = get_tree().get_first_node_in_group(LEVEL_HITBOX_GROUP)
    if hitbox:
        hitbox.mob_slipped_through.connect(_on_mob_slipped_through)

    PLAYER_MONEY_REMAINING = PLAYER_STARTING_MONEY
    MONEY_METER = get_tree().get_first_node_in_group(MONEY_METER_GROUP)
    MONEY_METER.update_value_text()

    LIVES_METER = get_tree().get_first_node_in_group(LIVES_METER_GROUP)
    LIVES_METER.update_value_text()

    TOWER_PLACEMENT_SHADOW = get_tree().get_first_node_in_group(TOWER_PLACEMENT_SHADOW_GROUP)

    SELECTED_TOWER_METER = get_tree().get_first_node_in_group(SELECTED_TOWER_METER_GROUP)

    NEXT_WAVE_METER = get_tree().get_first_node_in_group(NEXT_WAVE_METER_GROUP)

    TOWER_BUY_PANEL = get_tree().get_first_node_in_group(TOWER_BUY_PANEL_GROUP)
    TOWER_INFO_AND_BUY_PANEL = get_tree().get_first_node_in_group(TOWER_INFO_AND_BUY_PANEL_GROUP)

    AUDIO_CONTROL = get_tree().get_first_node_in_group(AUDIO_GROUP)

    assert(PLAYER_LIVES_REMAINING > 0, "Lives left on level start should be > 0!")
    assert(get_tree().get_first_node_in_group(GameState.MOBS_GROUP), "Missing a mobs node!")
    assert(get_tree().get_first_node_in_group(GameState.TOWERS_GROUP), "Missing a towers node!")
    assert(get_tree().get_first_node_in_group(GameState.PROJECTILES_GROUP), "Missing a projectiles node!")
    if !get_tree().current_scene.name.contains("MapSelect"):
        assert(CURRENT_LEVEL != null)

    Respawner._on_level_load()
    GameState.SHOULDNT_PAUSE = false

func add_money(value: int) -> void:
    PLAYER_MONEY_REMAINING += value
    if PLAYER_MONEY_REMAINING >= PLAYER_MAX_MONEY:
        PLAYER_MONEY_REMAINING = PLAYER_MAX_MONEY
    MONEY_METER.update_value_text()
    TOWER_INFO_AND_BUY_PANEL.recalculate_money()

func deduct_money(value: int) -> void:
    PLAYER_MONEY_REMAINING -= value
    if PLAYER_MONEY_REMAINING <= 0:
        PLAYER_MONEY_REMAINING = 0
    MONEY_METER.update_value_text()
    TOWER_INFO_AND_BUY_PANEL.recalculate_money()

func _input(event) -> void:
    if event.is_action_pressed("ui_pause_resume"):
        if SHOULDNT_PAUSE:
            return
        elif !get_tree().paused:
            pause_game()
        else:
            resume_game()

func resume_game() -> void:
    PAUSE_SCREEN.visible = false
    CURRENT_LEVEL.get_node("UI").remove_child(PAUSE_SCREEN)
    get_tree().paused = false

func pause_game() -> void:
    PAUSE_SCREEN.visible = true
    CURRENT_LEVEL.get_node("UI").add_child(PAUSE_SCREEN)
    get_tree().paused = true

func restart_game() -> void:
    IS_GAME_OVER = false
    get_tree().change_scene_to_file("res://levels/MapSelect.tscn")

func quit_game() -> void:
    get_tree().quit()

func toggle_sfx() -> void:
    if SFX_ENABLED:
        AUDIO_CONTROL.disable_sfx()
    else:
        AUDIO_CONTROL.enable_sfx()
    SFX_ENABLED = !SFX_ENABLED

func toggle_bgm() -> void:
    if BGM_ENABLED:
        AUDIO_CONTROL.disable_bgm()
    else:
        AUDIO_CONTROL.enable_bgm()
    BGM_ENABLED = !BGM_ENABLED

func _on_mob_slipped_through(mob: Mob) -> void:
    mob.delayed_despawn()

    if IS_GAME_OVER:
        return

    PLAYER_LIVES_REMAINING -= 1
    LIVES_METER.update_value_text()
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

func _on_mob_killed(mob: Mob) -> void:
    SCORE += mob.MAX_HP
    _on_mob_despawn(mob)

func _on_mob_despawn(_mob) -> void:
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

func _process(delta: float) -> void:
    AVG_FRAME_TIME = (AVG_FRAME_TIME + delta) / 2

func _get_target_init_window_size() -> Vector2i:
    var target_max_window_size: Vector2i = (
        DisplayServer.screen_get_size()
        * STARTING_WINDOW_SIZE_PERCENT
    )
    var current_max_window_size: Vector2i = get_window().size

    while (current_max_window_size < target_max_window_size):
        current_max_window_size = Vector2i(
            int(current_max_window_size.x * 1.1),
            int(current_max_window_size.y * 1.1)
        )

    return current_max_window_size
