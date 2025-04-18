class_name TowerBuyPanel
extends Control

@onready var PanelAnims: AnimationPlayer = $PanelAnims
@onready var BuyItemList: Control = $BuyItemList

const TOWERS_TO_BUY_LIST: Array = [
    "res://towers/BulletTower.tscn"
]

func _ready() -> void:
    for tower in TOWERS_TO_BUY_LIST:
        BuyItemList.add_child(TowerBuyItem.new(tower))

func _on_button_expand_left_pressed() -> void:
    PanelAnims.play("open")

func _on_button_contract_right_pressed() -> void:
    PanelAnims.play("close")
