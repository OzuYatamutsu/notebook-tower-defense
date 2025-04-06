class_name StartScreen
extends Control

@onready var StartLabel = $VBoxContainer/Control/Label

func _input(event) -> void:
    if !(
        event is InputEventMouseButton
        and event.is_pressed()
    ):
        return
    
    _on_mouse_click()

func _on_mouse_click() -> void:
    # TODO
    get_tree().change_scene_to_file("res://levels/test_level.tscn")
