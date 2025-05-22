class_name TowerUpgradePanel
extends Control

@export var SelectedTower: Tower

@onready var CurrentTowerSprite: Sprite2D = $CurrentTowerSprite
@onready var UpgradedComponent: Control = $UpgradedComponent
@onready var ToUpgradeComponent: Control = $ToUpgradeComponent
@onready var UpgradeItemList: VBoxContainer = $ToUpgradeComponent/UpgradeItemList

var CurrentTowerIsUpgraded: bool = false

func _ready() -> void:
    for child in UpgradeItemList.get_children():
        UpgradeItemList.remove_child(child)

func set_current_tower(tower: Tower):
    SelectedTower = tower
    CurrentTowerSprite.texture = SelectedTower.Sprite.texture

func _on_close_button_pressed() -> void:
    hide()
