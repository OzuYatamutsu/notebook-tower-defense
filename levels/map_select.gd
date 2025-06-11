class_name MapSelect
extends Control

const LOAD_MAP_NAME = "LoadMapButton"

var LABEL_LEVEL_MAP = {
    "EasyStreet": "res://levels/test_level.tscn",
    "CoolS": "res://levels/level_cools.tscn",
    "SwitchbackVTD": "res://levels/level_switchback.tscn",
    "FELite": "res://levels/level_fe_lite.tscn",
    "Digestion": "res://levels/level_digestion.tscn",
    "Splits": "res://levels/level_splits.tscn"
}

var CurrentSelectedLevel: String = LABEL_LEVEL_MAP["EasyStreet"]

@onready var MapPreview: Sprite2D = $map
@onready var LoadLevelButton: Button = $Selector/LoadMapButton

func _ready() -> void:
    LoadLevelButton.disabled = true
    
    for _button in find_children("", "Button", true, true):
        _button.pressed.connect(
            _on_button_pressed.bind(_button.name)
        )
        _button.disabled = false

func load_level_preview(path_to_level: String) -> void:
    CurrentSelectedLevel = path_to_level

    var level: Level = load(CurrentSelectedLevel).instantiate()
    var level_map: Sprite2D = level.get_node("LevelViewport/map")
    var viewport_size: Vector2 = get_viewport_rect().size
    var level_map_size: Vector2 = level_map.texture.get_size()
    
    MapPreview.texture = level_map.texture
    
    # Scale map to fit viewport
    MapPreview.scale = Vector2(
        viewport_size.x / level_map_size.x,
        viewport_size.y / level_map_size.y
    )

func load_selected_level() -> void:
    assert(CurrentSelectedLevel != null)
    
    get_tree().change_scene_to_file(CurrentSelectedLevel)

func _on_button_pressed(button_name: String) -> void:
    if CurrentSelectedLevel != null and button_name == LOAD_MAP_NAME:
        load_selected_level()
        return

    load_level_preview(LABEL_LEVEL_MAP[button_name])

    # Unset all other buttons
    for _button in find_children("", "Button", true, true):
        if _button.name == button_name:
            _button.disabled = true
            continue
        _button.disabled = false
