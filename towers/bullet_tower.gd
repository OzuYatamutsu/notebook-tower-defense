class_name BulletTower
extends Tower

func _init() -> void:
    VALUE = 100
    super._init()

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/Bullet.tscn"),
        2000.00,
        1.0
    )

    enable()
