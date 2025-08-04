class_name TowerPlacementShadow
extends Node2D

@export var TOWER_TO_PLACE: Tower = preload("res://towers/BulletTower.tscn").instantiate()
@export var TOWER_TO_PLACE_PATH: String = "res://towers/BulletTower.tscn"
@export var MOUSE_FOLLOW_SPEED: float = 10.0
@export var HoveringOverTower: Tower = null
@export var IsHoveringOverWall: bool = false

@onready var OK_SHADOW: ColorRect = $ColorRectOK
@onready var NG_SHADOW: ColorRect = $ColorRectNG
@onready var NG_MONEY: Label = $NGMoney
@onready var TowerSprite: Sprite2D = $TowerSprite

var IsActive: bool = false

func _ready() -> void:
    OK_SHADOW.visible = false
    NG_SHADOW.visible = false
    NG_MONEY.visible = false
    TowerSprite.visible = false

func _process(delta) -> void:
    position = position.lerp(
        get_global_mouse_position(),
        MOUSE_FOLLOW_SPEED * delta
    )

func _input(event) -> void:
    if !(
        event is InputEventMouseButton
        and event.is_pressed()
        and event.button_index == MOUSE_BUTTON_LEFT
    ):
        return

    if !IsActive and HoveringOverTower != null:
        GameState.TOWER_INFO_AND_BUY_PANEL.info_mode(HoveringOverTower)
    elif !IsActive:
        return

    # We should create the tower at the current location,
    # then deactivate the shadow.
    spawn()
    deactivate()

func activate(towerPath: String, tower: Tower) -> void:
    TOWER_TO_PLACE_PATH = towerPath
    TOWER_TO_PLACE = tower
    TowerSprite.texture = tower.get_node("Sprite").texture
    TowerSprite.visible = true
    IsActive = true

func deactivate() -> void:
    TowerSprite.visible = false
    IsActive = false

func spawn() -> void:
    var new_tower = load(TOWER_TO_PLACE_PATH).instantiate()

    get_tree().get_first_node_in_group(
        GameState.TOWERS_GROUP
    ).add_child(
        new_tower
    )

    new_tower.global_position = get_global_mouse_position()
    GameState.deduct_money(TOWER_TO_PLACE.VALUE)

func _on_area_entered(tower_or_wall: Area2D) -> void:
    if tower_or_wall is Tower:
        HoveringOverTower = tower_or_wall
    elif tower_or_wall.is_in_group(GameState.WALLS_GROUP):
        IsHoveringOverWall = true

func _on_area_exited(tower_or_wall: Area2D) -> void:
    if tower_or_wall is Tower:
        HoveringOverTower = null
    elif tower_or_wall.is_in_group(GameState.WALLS_GROUP):
        IsHoveringOverWall = false
