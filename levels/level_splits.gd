class_name Level_Splits
extends Level

func _init() -> void:
    WAVE_CONTENTS = [
        {"res://mobs/Basic.tscn": 10},
        {"res://mobs/Basic.tscn": 10},
        {"res://mobs/Nyoom.tscn": 10},
        {"res://mobs/Nyoom.tscn": 5},
        {"res://mobs/BigBoss.tscn": 1},
        {"res://mobs/Basic.tscn": 10, "res://mobs/FatOne.tscn": 10},
        {"res://mobs/Basic.tscn": 15},
        {"res://mobs/Nyoom.tscn": 10},
        {"res://mobs/BigBoss.tscn": 1, "res://mobs/FatOne.tscn": 10},
        {"res://mobs/FatOne.tscn": 25},
        {"res://mobs/Basic.tscn": 25},
        {"res://mobs/FatOne.tscn": 25},
        {"res://mobs/Nyoom.tscn": 20, "res://mobs/Basic.tscn": 50},
        {"res://mobs/Nyoom.tscn": 20, "res://mobs/FatOne.tscn": 25},
        {"res://mobs/Basic.tscn": 35, "res://mobs/Nyoom.tscn": 20, "res://mobs/FatOne.tscn": 35},
        {"res://mobs/Basic.tscn": 50},
        {"res://mobs/FatOne.tscn": 50},
        {"res://mobs/Basic.tscn": 35, "res://mobs/Nyoom.tscn": 35, "res://mobs/FatOne.tscn": 35},
        {"res://mobs/BigBoss.tscn": 1, "res://mobs/Basic.tscn": 35, "res://mobs/Nyoom.tscn": 35, "res://mobs/FatOne.tscn": 35},
        {"res://mobs/Basic.tscn": 55, "res://mobs/Nyoom.tscn": 55, "res://mobs/FatOne.tscn": 55},
    ]

func _ready():
    super._ready()
    start_wave()
