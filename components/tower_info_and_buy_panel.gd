class_name TowerInfoAndBuyPanel
extends Control

@onready var ButtonToTowerPathMap = {
    "BulletTower": "res://towers/BulletTower.tscn",
    "SlowTower": "res://towers/SlowTower.tscn",
    "LaserTower": "res://towers/LaserTower.tscn",
    "SpikeTower": "res://towers/SpikeTower.tscn",
    "SniperTower": "res://towers/SniperTower.tscn",
    "MissileTower": "res://towers/MissileTower.tscn",
    "SlowflakeTower": "res://towers/SlowflakeTower.tscn",
    "SlowthrowerTower": "res://towers/SlowthrowerTower.tscn",
    "FastLaserTower": "res://towers/FastLaserTower.tscn",
    "HeavyLaserTower": "res://towers/HeavyLaserTower.tscn",
    "PoisonSpikeTower": "res://towers/PoisonSpikeTower.tscn",
    "MineTower": "res://towers/MineTower.tscn"
}

@onready var ButtonToTowerMap = {
    "BulletTower": load(ButtonToTowerPathMap["BulletTower"]).instantiate(),
    "SlowTower": load(ButtonToTowerPathMap["SlowTower"]).instantiate(),
    "LaserTower": load(ButtonToTowerPathMap["LaserTower"]).instantiate(),
    "SpikeTower": load(ButtonToTowerPathMap["SpikeTower"]).instantiate(),
    "SniperTower": load(ButtonToTowerPathMap["SniperTower"]).instantiate(),
    "MissileTower": load(ButtonToTowerPathMap["MissileTower"]).instantiate(),
    "SlowflakeTower": load(ButtonToTowerPathMap["SlowflakeTower"]).instantiate(),
    "SlowthrowerTower": load(ButtonToTowerPathMap["SlowthrowerTower"]).instantiate(),
    "FastLaserTower": load(ButtonToTowerPathMap["FastLaserTower"]).instantiate(),
    "HeavyLaserTower": load(ButtonToTowerPathMap["HeavyLaserTower"]).instantiate(),
    "PoisonSpikeTower": load(ButtonToTowerPathMap["PoisonSpikeTower"]).instantiate(),
    "MineTower": load(ButtonToTowerPathMap["MineTower"]).instantiate()
}

@onready var TowerBuySelectPanel: FlowContainer = $BuyPanel/TowerSelectPanel
@onready var TowerUpgradeSelectPanel: FlowContainer = $UpgradePanel/TowerSelectPanel

@onready var BulletTowerButton: Button = $BuyPanel/TowerSelectPanel/BulletTower
@onready var SlowTowerButton: Button = $BuyPanel/TowerSelectPanel/SlowTower
@onready var LaserTowerButton: Button = $BuyPanel/TowerSelectPanel/LaserTower
@onready var SpikeTowerButton: Button = $BuyPanel/TowerSelectPanel/SpikeTower
@onready var SniperTowerButton: Button = $UpgradePanel/TowerSelectPanel/SniperTower
@onready var MissileTowerButton: Button = $UpgradePanel/TowerSelectPanel/MissileTower
@onready var SlowflakeTowerButton: Button = $UpgradePanel/TowerSelectPanel/SlowflakeTower
@onready var SlowthrowerTowerButton: Button = $UpgradePanel/TowerSelectPanel/SlowthrowerTower
@onready var FastLaserTowerButton: Button = $UpgradePanel/TowerSelectPanel/FastLaserTower
@onready var HeavyLaserTowerButton: Button = $UpgradePanel/TowerSelectPanel/HeavyLaserTower
@onready var PoisonSpikeTowerButton: Button = $UpgradePanel/TowerSelectPanel/PoisonSpikeTower
@onready var MineTowerButton: Button = $UpgradePanel/TowerSelectPanel/MineTower

@onready var DescriptionPanel: Label = $DescriptionPanel
@onready var SpawnShadow: TowerPlacementShadow = get_tree().get_first_node_in_group(
    GameState.TOWER_PLACEMENT_SHADOW_GROUP
)

func _ready() -> void:
    DescriptionPanel.text = ""

    for tower: Button in (
        TowerBuySelectPanel.get_children()
        + TowerUpgradeSelectPanel.get_children()
    ):
        tower.mouse_entered.connect(
            _on_button_rollover.bind(tower)
        )
        tower.mouse_exited.connect(_on_button_exit)
        tower.pressed.connect(
            _on_button_click.bind(tower)
        )

func _on_button_rollover(button: Button) -> void:
    var tower: Tower = ButtonToTowerMap[button.name]
    DescriptionPanel.text = tower.Description

func _on_button_exit() -> void:
    DescriptionPanel.text = ""

func _on_button_click(button: Button) -> void:
    SpawnShadow.activate(
        ButtonToTowerPathMap[button.name],
        ButtonToTowerMap[button.name]
    )

func recalculate_money() -> void:
    # Deactivate buttons if we can't afford them
    # Active buttons if we can
    for tower: String in ButtonToTowerMap:
        var target = TowerBuySelectPanel.find_child(tower)
        if target == null:
            target = TowerUpgradeSelectPanel.find_child(tower)

        if (
            GameState.PLAYER_MONEY_REMAINING
            < ButtonToTowerMap[tower].VALUE
        ):
            target.disabled = true
        else:
            target.disabled = false
