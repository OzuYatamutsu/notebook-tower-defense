class_name CoolS
extends Level

func _init() -> void:
    WAVE_CONTENTS = [
        {"res://mobs/Basic.tscn": 5},
        {"res://mobs/Basic.tscn": 10},
        {"res://mobs/Basic.tscn": 15},
        {"res://mobs/Basic.tscn": 15, "res://mobs/FatOne.tscn": 1},
        {"res://mobs/Basic.tscn": 15, "res://mobs/FatOne.tscn": 2},
        {"res://mobs/Basic.tscn": 20, "res://mobs/FatOne.tscn": 3},
        {"res://mobs/Basic.tscn": 25, "res://mobs/FatOne.tscn": 4},
        {"res://mobs/Basic.tscn": 30, "res://mobs/FatOne.tscn": 5},
        {"res://mobs/Basic.tscn": 35, "res://mobs/FatOne.tscn": 6},
        {"res://mobs/Basic.tscn": 35, "res://mobs/BigBoss.tscn": 1},
        {"res://mobs/Basic.tscn": 35, "res://mobs/Nyoom.tscn": 5, "res://mobs/FatOne.tscn": 6},
        {"res://mobs/Basic.tscn": 35, "res://mobs/Nyoom.tscn": 6, "res://mobs/FatOne.tscn": 7},
        {"res://mobs/Basic.tscn": 35, "res://mobs/Nyoom.tscn": 7, "res://mobs/FatOne.tscn": 8},
        {"res://mobs/Basic.tscn": 35, "res://mobs/Nyoom.tscn": 8, "res://mobs/FatOne.tscn": 9},
        {"res://mobs/Basic.tscn": 35, "res://mobs/Nyoom.tscn": 9, "res://mobs/FatOne.tscn": 10},
        {"res://mobs/Basic.tscn": 50, "res://mobs/Nyoom.tscn": 10, "res://mobs/FatOne.tscn": 11},
        {"res://mobs/Basic.tscn": 50, "res://mobs/Nyoom.tscn": 11, "res://mobs/FatOne.tscn": 12},
        {"res://mobs/Basic.tscn": 50, "res://mobs/Nyoom.tscn": 12, "res://mobs/FatOne.tscn": 13},
        {"res://mobs/Basic.tscn": 50, "res://mobs/Nyoom.tscn": 13, "res://mobs/FatOne.tscn": 14},
        {"res://mobs/Basic.tscn": 50, "res://mobs/Nyoom.tscn": 15, "res://mobs/FatOne.tscn": 15, "res://mobs/BigBoss.tscn": 1}
    ]

func _ready():
    super._ready()
    start_wave()
