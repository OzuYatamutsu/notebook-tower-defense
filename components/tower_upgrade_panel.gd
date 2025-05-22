class_name TowerUpgradePanel
extends Control

const _upgradeItem = preload("res://components/TowerUpgradeItem.tscn")

@export var SelectedTower: Tower

@onready var CurrentTowerSprite: TextureRect = $CurrentTowerSprite
@onready var UpgradedComponent: Control = $UpgradedComponent
@onready var ToUpgradeComponent: Control = $ToUpgradeComponent
@onready var UpgradeItemList: VBoxContainer = $ToUpgradeComponent/UpgradeItemList

var CurrentTowerIsUpgraded: bool = false

func _ready() -> void:
    for child in UpgradeItemList.get_children():
        UpgradeItemList.remove_child(child)

func enable() -> void:
    GameState.TOWER_BUY_PANEL.hide()
    GameState.SELECTED_TOWER_METER.hide()
    show()

func disable() -> void:
    GameState.SELECTED_TOWER_METER.show()
    GameState.TOWER_BUY_PANEL.show()
    hide()

func clear_upgrades() -> void:
    for child in UpgradeItemList.get_children():
        UpgradeItemList.remove_child(child)

func set_current_tower(tower: Tower):
    SelectedTower = tower
    CurrentTowerSprite.texture = SelectedTower.Sprite.texture
    CurrentTowerIsUpgraded = SelectedTower.IsUpgraded
    clear_upgrades()
    for upgrade_tower in SelectedTower.UpgradesTo:
        add_tower_upgrade_path_element(upgrade_tower)

    if CurrentTowerIsUpgraded:
        UpgradedComponent.show()
        ToUpgradeComponent.hide()
    else:
        UpgradedComponent.hide()
        ToUpgradeComponent.show()

func add_tower_upgrade_path_element(tower: Tower) -> void:
    if !tower.IsUpgraded:
        print(
            "Warning: attempted to add upgrade path to " +
            "a non-upgraded tower, stubbing"
        )
        return
    
    var _item = _upgradeItem.instantiate()
    _item.setup(tower)
    UpgradeItemList.add_child(_item)

func _on_close_button_pressed() -> void:
    disable()
