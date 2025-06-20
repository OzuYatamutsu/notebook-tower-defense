class_name BulletTower
extends Tower

func _init() -> void:
    VALUE = 100
    UpgradesTo = [
        "res://towers/SniperTower.tscn",
        "res://towers/MissileTower.tscn"
    ]
    IsUpgraded = false
    super._init()

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/Bullet.tscn"),
        1000.00,  # Range
        1.0  # Rate of fire
    )

    enable()
