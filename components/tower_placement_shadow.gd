class_name TowerPlacementShadow
extends Node2D

@export var TOWER_TO_PLACE: Tower = preload("res://towers/BulletTower.tscn").instantiate()
@export var TOWER_TO_PLACE_PATH: String = "res://towers/BulletTower.tscn"
@export var MOUSE_FOLLOW_SPEED: float = 10.0

@onready var OK_SHADOW = $ColorRectOK
@onready var NG_SHADOW = $ColorRectNG

var HoveringOverTower: Tower

enum ShadowState {
    DISABLED,  # Don't show the shadow at all
    NG_OVERLAPPING,  # Can't place the tower due to overlap
    NG_INSUFFICIENT_FUNDS,  # Can't place the tower due to not enough money
    NG_NOT_IN_WALLS_AREA,  # Can't place the tower due to not part of a wall
    OK  # Can place the tower
}

var is_ok: bool = false
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

    set_is_ok()

func _input(event) -> void:
    if !(
        event is InputEventMouseButton
        and event.is_pressed()
        and event.button_index == MOUSE_BUTTON_LEFT
    ):
        return

    if current_state == ShadowState.DISABLED:
        return

    if !is_ok and current_state == ShadowState.NG_OVERLAPPING:
        print("Overlapping another tower, opening upgrade panel!")
        GameState.TOWER_UPGRADE_PANEL.set_current_tower(HoveringOverTower)
        GameState.TOWER_UPGRADE_PANEL.enable()
        return
    elif !is_ok and current_state == ShadowState.NG_INSUFFICIENT_FUNDS:
        print("Not spawning tower; insufficient funds")
        return
    elif !is_ok and current_state == ShadowState.NG_NOT_IN_WALLS_AREA:
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
    set_is_ok()

func set_is_ok() -> void:
    if TOWER_TO_PLACE == null:
        current_state = ShadowState.DISABLED
        OK_SHADOW.visible = false
        NG_SHADOW.visible = false
        return

    # Don't show the shadow if we're hovering over a button
    if is_hovering_over_button():
        current_state = ShadowState.DISABLED
    elif current_state != ShadowState.NG_NOT_IN_WALLS_AREA:
        current_state = reeval_current_state()

    if (
        current_state == ShadowState.NG_INSUFFICIENT_FUNDS
        and GameState.PLAYER_MONEY_REMAINING >= TOWER_TO_PLACE.VALUE
    ):
        current_state = ShadowState.OK
    
    if current_state == ShadowState.OK:
        is_ok = true
        OK_SHADOW.visible = true
        NG_SHADOW.visible = false
    elif current_state in [
        ShadowState.NG_OVERLAPPING,
        ShadowState.NG_INSUFFICIENT_FUNDS,
        ShadowState.NG_NOT_IN_WALLS_AREA
    ]:
        is_ok = false
        OK_SHADOW.visible = false
        NG_SHADOW.visible = true
    else:
        OK_SHADOW.visible = false
        NG_SHADOW.visible = false

func is_hovering_over_button() -> bool:
    return get_viewport().gui_get_hovered_control() is Button

func _on_area_entered(tower_or_wall: Area2D) -> void:
    if TOWER_TO_PLACE == null:
        return
    if tower_or_wall is Tower:
        current_state = ShadowState.NG_OVERLAPPING
        HoveringOverTower = tower_or_wall
    elif tower_or_wall.is_in_group(GameState.WALLS_GROUP):
        current_state = reeval_current_state()

func _on_area_exited(tower_or_wall: Area2D) -> void:
    if TOWER_TO_PLACE == null:
        return
    if tower_or_wall.is_in_group(GameState.WALLS_GROUP):
        current_state = ShadowState.NG_NOT_IN_WALLS_AREA
    else:
        current_state = reeval_current_state()
    HoveringOverTower = null

func reeval_current_state() -> ShadowState:
    if HoveringOverTower != null:
        return ShadowState.NG_OVERLAPPING

    return (
        ShadowState.OK
        if GameState.PLAYER_MONEY_REMAINING >= TOWER_TO_PLACE.VALUE
        else ShadowState.NG_INSUFFICIENT_FUNDS
    )
