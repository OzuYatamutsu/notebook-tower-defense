class_name MapSelect
extends Control

const LOAD_MAP_NAME = "LoadMapButton"

var LABEL_LEVEL_MAP = {
    "TestLevel": "res://levels/test_level.tscn",
    "Level1": "res://levels/level1.tscn"
}

var CurrentSelectedLevel: String

@onready var MapPreview: Sprite2D = $map
@onready var LoadLevelButton: Button = $Selector/LoadMapButton

func _ready() -> void:
    LoadLevelButton.disabled = true
    
    for _button in find_children("", "Button", true, true):
        if _button.name == LOAD_MAP_NAME:
            _button.disabled = true
            continue
        _button.disabled = false
        _button.pressed.connect(_on_button_pressed.bind(_button.name))

func load_level_preview(path_to_level: String) -> void:
    CurrentSelectedLevel = path_to_level

    var level: Level = load(CurrentSelectedLevel).instantiate()
    var level_map: Sprite2D = level.get_node("LevelViewport/map")
    
    MapPreview.texture = level_map.texture

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

    LoadLevelButton.disabled = false
