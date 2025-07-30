class_name TowerInfoAndBuyPanel
extends Control

@onready var ButtonToTowerPathMap = {
    "BulletTower": "res://towers/BulletTower.tscn",
    "SlowTower": "res://towers/SlowTower.tscn",
    "LaserTower": "res://towers/LaserTower.tscn",
    "SpikeTower": "res://towers/SpikeTower.tscn"
}

@onready var ButtonToTowerMap = {
    "BulletTower": load(ButtonToTowerPathMap["BulletTower"]).instantiate(),
    "SlowTower": load(ButtonToTowerPathMap["SlowTower"]).instantiate(),
    "LaserTower": load(ButtonToTowerPathMap["LaserTower"]).instantiate(),
    "SpikeTower": load(ButtonToTowerPathMap["SpikeTower"]).instantiate()
}

@onready var TowerSelectPanel: FlowContainer = $TowerSelectPanel
@onready var BulletTowerButton: Button = $TowerSelectPanel/BulletTower
@onready var SlowTowerButton: Button = $TowerSelectPanel/SlowTower
@onready var LaserTowerButton: Button = $TowerSelectPanel/LaserTower
@onready var SpikeTowerButton: Button = $TowerSelectPanel/SpikeTower
@onready var DescriptionPanel: Label = $DescriptionPanel
@onready var SpawnShadow: TowerPlacementShadow = get_tree().get_first_node_in_group(
    GameState.TOWER_PLACEMENT_SHADOW_GROUP
)

func _ready() -> void:
    DescriptionPanel.text = ""

    for tower: Button in TowerSelectPanel.get_children():
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
