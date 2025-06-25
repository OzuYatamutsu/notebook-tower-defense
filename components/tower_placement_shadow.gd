class_name TowerPlacementShadow
extends Node2D

@export var TOWER_TO_PLACE: Tower = preload("res://towers/BulletTower.tscn").instantiate()
@export var TOWER_TO_PLACE_PATH: String = "res://towers/BulletTower.tscn"
@export var MOUSE_FOLLOW_SPEED: float = 10.0

@onready var OK_SHADOW: ColorRect = $ColorRectOK
@onready var NG_SHADOW: ColorRect = $ColorRectNG
@onready var NG_MONEY: Label = $NGMoney

var HoveringOverTower: Tower
var IsHoveringOverWall: bool = false

enum ShadowState {
    DISABLED,  # Don't show the shadow at all
    NG_OVERLAPPING,  # Can't place the tower due to overlap
    NG_INSUFFICIENT_FUNDS,  # Can't place the tower due to not enough money
    NG_NOT_IN_WALLS_AREA,  # Can't place the tower due to not part of a wall
    OK  # Can place the tower
}

var current_state: ShadowState = ShadowState.DISABLED

func set_tower(scene_path: String) -> void:
    if TOWER_TO_PLACE:
        TOWER_TO_PLACE.queue_free()
    TOWER_TO_PLACE = load(scene_path).instantiate()
    TOWER_TO_PLACE_PATH = scene_path

func _process(delta) -> void:
    position = position.lerp(
        get_global_mouse_position(),
        MOUSE_FOLLOW_SPEED * delta
    )

    set_shadow_state()
    set_ng_label()

func set_shadow_state() -> void:
    # Evaluate rules in the following order:
    # 0. We can't build anything if we have no tower selected.
    # 1. We can't build anything if we're not over a wall.
    # 2. If we're over a tower, we still can't build anything,
    #    but a click should open the upgrade menu.
    # 2. We can't build anything if we don't have enough money.

    if is_hovering_over_button():
        current_state = ShadowState.DISABLED
    elif TOWER_TO_PLACE == null:
        current_state = ShadowState.DISABLED
    elif HoveringOverTower != null:
        current_state = ShadowState.NG_OVERLAPPING
    elif !IsHoveringOverWall:
        current_state = ShadowState.NG_NOT_IN_WALLS_AREA
    elif GameState.PLAYER_MONEY_REMAINING < TOWER_TO_PLACE.VALUE:
        current_state = ShadowState.NG_INSUFFICIENT_FUNDS
    else:
        current_state = ShadowState.OK

func _input(event) -> void:
    if !(
        event is InputEventMouseButton
        and event.is_pressed()
        and event.button_index == MOUSE_BUTTON_LEFT
    ):
        return

    if current_state == ShadowState.DISABLED:
        return

    if current_state == ShadowState.NG_OVERLAPPING:
        print("Overlapping another tower, opening upgrade panel!")
        GameState.TOWER_UPGRADE_PANEL.set_current_tower(HoveringOverTower)
        GameState.TOWER_UPGRADE_PANEL.enable()
        return
    elif current_state == ShadowState.NG_INSUFFICIENT_FUNDS:
        print("Not spawning tower; insufficient funds")
        return
    elif current_state == ShadowState.NG_NOT_IN_WALLS_AREA:
        print("Not spawning tower; not in a walls area")
        return
    
    print("Spawning tower! " + str(TOWER_TO_PLACE))
    spawn()

func spawn() -> void:
    var new_tower = load(TOWER_TO_PLACE_PATH).instantiate()

    get_tree().get_first_node_in_group(
        GameState.TOWERS_GROUP
    ).add_child(
        new_tower
    )

    new_tower.global_position = get_global_mouse_position()
    GameState.deduct_money(TOWER_TO_PLACE.VALUE)
    
    # Force hovering over tower state
    current_state = ShadowState.NG_OVERLAPPING
    HoveringOverTower = new_tower

func is_hovering_over_button() -> bool:
    return get_viewport().gui_get_hovered_control() is Button

func _on_area_entered(tower_or_wall: Area2D) -> void:
    if TOWER_TO_PLACE == null:
        return
    if tower_or_wall is Tower:
        HoveringOverTower = tower_or_wall
    elif tower_or_wall.is_in_group(GameState.WALLS_GROUP):
        IsHoveringOverWall = true

func _on_area_exited(tower_or_wall: Area2D) -> void:
    if TOWER_TO_PLACE == null:
        return
    if tower_or_wall is Tower:
        HoveringOverTower = null
    elif tower_or_wall.is_in_group(GameState.WALLS_GROUP):
        IsHoveringOverWall = false

func set_ng_label() -> void:
    OK_SHADOW.visible = false
    NG_SHADOW.visible = false
    NG_MONEY.visible = false

    if current_state == ShadowState.OK:
        OK_SHADOW.visible = true
    elif current_state == ShadowState.DISABLED:
        pass  # Don't show any shadow
    elif current_state == ShadowState.NG_INSUFFICIENT_FUNDS:
        NG_SHADOW.visible = true
        NG_MONEY.visible = true
    elif current_state == ShadowState.NG_OVERLAPPING:
        pass  # Don't show any shadow
    elif current_state == ShadowState.NG_NOT_IN_WALLS_AREA:
        NG_SHADOW.visible = true
