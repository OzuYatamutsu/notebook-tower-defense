class_name TowerInfoAndBuyPanel
extends Control

@export var IsOpened: bool = false

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
