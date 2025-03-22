class_name LevelSpawn
extends Area2D

signal mob_exited

func _ready() -> void:
    pass

func _on_area_exited(mob: Mob) -> void:
    print(str(mob) + " entered the level!")
