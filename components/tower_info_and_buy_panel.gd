class_name TowerInfoAndBuyPanel
extends Control

@onready var ButtonToTowerMap = {
    "BulletTower": preload("res://towers/BulletTower.tscn").instantiate(),
    "SlowTower": preload("res://towers/SlowTower.tscn").instantiate(),
    "LaserTower": preload("res://towers/LaserTower.tscn").instantiate(),
    "SpikeTower": preload("res://towers/SpikeTower.tscn").instantiate()
}

@onready var BulletTowerButton: Button = $TowerSelectPanel/BulletTower
@onready var SlowTowerButton: Button = $TowerSelectPanel/SlowTower
@onready var LaserTowerButton: Button = $TowerSelectPanel/LaserTower
@onready var SpikeTowerButton: Button = $TowerSelectPanel/SpikeTower
@onready var DescriptionPanel: Label = $DescriptionPanel

func _ready() -> void:
    DescriptionPanel.text = ""

    BulletTowerButton.mouse_entered.connect(
        _on_button_rollover.bind(BulletTowerButton)
    )
    BulletTowerButton.mouse_exited.connect(_on_button_exit)
    SlowTowerButton.mouse_entered.connect(
        _on_button_rollover.bind(SlowTowerButton)
    )
    SlowTowerButton.mouse_exited.connect(_on_button_exit)
    LaserTowerButton.mouse_entered.connect(
        _on_button_rollover.bind(LaserTowerButton)
    )
    LaserTowerButton.mouse_exited.connect(_on_button_exit)
    SpikeTowerButton.mouse_entered.connect(
        _on_button_rollover.bind(SpikeTowerButton)
    )
    SpikeTowerButton.mouse_exited.connect(_on_button_exit)

func _on_button_rollover(button: Button) -> void:
    var tower: Tower = ButtonToTowerMap[button.name]
    DescriptionPanel.text = tower.Description

func _on_button_exit() -> void:
    DescriptionPanel.text = ""
