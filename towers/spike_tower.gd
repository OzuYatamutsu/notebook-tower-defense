class_name SpikeTower
extends Tower

func _init() -> void:
    VALUE = 250
    UpgradesTo = [
        "res://towers/MineTower.tscn",
        "res://towers/PoisonSpikeTower.tscn"
    ]
    IsUpgraded = false
    super._init()

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/Spike.tscn"),
        2000.00,  # Range
        1.0  # Rate of fire
    )

    enable()
