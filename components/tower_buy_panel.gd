class_name TowerBuyPanel
extends Control

@onready var PanelAnims: AnimationPlayer = $PanelAnims
@onready var BuyItemList: Control = $BuyItemList

const TOWERS_TO_BUY_LIST: Array = [
    "res://towers/BulletTower.tscn"
]

const _buyItem = preload("res://components/TowerBuyItem.tscn")

func _ready() -> void:
    BuyItemList.remove_child(BuyItemList.get_child(0))

    for tower in TOWERS_TO_BUY_LIST:
        var _item = _buyItem.instantiate()
        _item.setup(tower)
        BuyItemList.add_child(_item)

func _on_button_expand_left_pressed() -> void:
    PanelAnims.play("open")

func _on_button_contract_right_pressed() -> void:
    PanelAnims.play("close")
