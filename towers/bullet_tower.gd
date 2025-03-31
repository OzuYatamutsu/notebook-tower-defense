class_name BulletTower
extends Tower

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/Bullet.tscn"),
        2000.00,
        1.0
    )

    # TODO
    enable()
