class_name TowerBuyPanel
extends Control

@onready var PanelAnims = $PanelAnims

func _on_button_expand_left_pressed() -> void:
    PanelAnims.play("open")

func _on_button_contract_right_pressed() -> void:
    PanelAnims.play("closed")
