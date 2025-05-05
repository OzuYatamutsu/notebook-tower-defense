class_name MapSelect
extends Control

const LOAD_MAP_NAME = "LoadMapButton"

var LABEL_LEVEL_MAP = {
    "TestLevel": "res://levels/test_level.tscn",
    "Level1": "res://levels/level1.tscn"
}

var CurrentSelectedLevel: String

@onready var MapPreview: Sprite2D = $map
@onready var LoadLevelButton: Button = $Selector/LoadLevelButton

func _ready() -> void:
    LoadLevelButton.disabled = true

func load_level_preview(path_to_level: String) -> void:
    CurrentSelectedLevel = path_to_level

    var level: Level = load(CurrentSelectedLevel).instantiate()
    var level_map: Sprite2D = level.get_node("LevelViewport/map")
    
    MapPreview.texture = level_map.texture

func load_selected_level() -> void:
    assert(CurrentSelectedLevel != null)
    
    get_tree().change_scene_to_file(CurrentSelectedLevel)

func _on_button_pressed(button: Button) -> void:
    if CurrentSelectedLevel != null and button.name == LOAD_MAP_NAME:
        load_selected_level()
        return
    
    load_level_preview(LABEL_LEVEL_MAP[button.name])
    
    # Unset all other buttons
    for _button in find_children("", "Button", true, true):
        _button.disabled = false
    button.disabled = true
    LoadLevelButton.disabled = false
