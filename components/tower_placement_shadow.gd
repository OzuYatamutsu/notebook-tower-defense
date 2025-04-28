class_name TowerPlacementShadow
extends Node2D

@export var TOWER_TO_PLACE: Tower
@export var MOUSE_FOLLOW_SPEED: float = 10.0

@onready var OK_SHADOW = $ColorRectOK
@onready var NG_SHADOW = $ColorRectNG

enum ShadowState {
    DISABLED,  # Don't show the shadow at all
    NG_OVERLAPPING,  # Can't place the tower due to overlap
    NG_INSUFFICIENT_FUNDS,  # Can't place the tower due to not enough money
    NG_NOT_IN_WALLS_AREA,  # Can't place the tower due to not part of a wall
    OK  # Can place the tower
}

var is_ok: bool = false
var current_state: ShadowState = ShadowState.DISABLED

func _ready() -> void:
    set_tower("res://towers/BulletTower.tscn")

func set_tower(scene_path: String) -> void:
    TOWER_TO_PLACE = load(scene_path).instantiate()

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
        print("Not spawning tower; overlapping another tower")
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
    var new_tower = TOWER_TO_PLACE.duplicate()

    get_tree().get_first_node_in_group(
        GameState.TOWERS_GROUP
    ).add_child(
        new_tower
    )

    new_tower.global_position = get_global_mouse_position()
    GameState.deduct_money(TOWER_TO_PLACE.VALUE)

func set_is_ok() -> void:
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
    # Intersected with an Area2D corresponding to a Tower.
    # This means we can't place a new tower here;
    # it would overlap an existing tower.

    if tower_or_wall is Tower:
        current_state = ShadowState.NG_OVERLAPPING
    elif tower_or_wall.is_in_group(GameState.WALLS_GROUP):
        current_state = reeval_current_state()

func _on_area_exited(tower_or_wall: Area2D) -> void:
    # No longer intersecting with an Area2D corresponding to a Tower.
    # We're able to place towers if we have enough money.
    
    if tower_or_wall.is_in_group(GameState.WALLS_GROUP):
        current_state = ShadowState.NG_NOT_IN_WALLS_AREA
    else:
        current_state = reeval_current_state()

func reeval_current_state() -> ShadowState:
    return (
        ShadowState.OK
        if GameState.PLAYER_MONEY_REMAINING >= TOWER_TO_PLACE.VALUE
        else ShadowState.NG_INSUFFICIENT_FUNDS
    )
