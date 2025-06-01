class_name TowerBuyPanel
extends Control

@export var IsOpened: bool = false

@onready var PanelAnims: AnimationPlayer = $PanelAnims
@onready var BuyItemList: Control = $BuyItemList

const TOWERS_TO_BUY_LIST: Array = [
    "res://towers/BulletTower.tscn",
    "res://towers/SlowTower.tscn",
    "res://towers/LaserTower.tscn",
    "res://towers/SpikeTower.tscn"
]

const _buyItem = preload("res://components/TowerBuyItem.tscn")

func _ready() -> void:
    BuyItemList.remove_child(BuyItemList.get_child(0))

    for tower in TOWERS_TO_BUY_LIST:
        var _item = _buyItem.instantiate()
        _item.setup(tower)
        BuyItemList.add_child(_item)

func open():
    if IsOpened:
        return
    _on_button_expand_left_pressed()

func close():
    if !IsOpened:
        return
    _on_button_contract_right_pressed()

func _on_button_expand_left_pressed() -> void:
    IsOpened = true
    PanelAnims.play("open")

func _on_button_contract_right_pressed() -> void:
    IsOpened = false
    PanelAnims.play("close")
