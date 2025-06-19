class_name Level_Fe_Lite
extends Level

func _init() -> void:
    WAVE_CONTENTS = [
        {"res://mobs/Basic.tscn": 10},
        {"res://mobs/Basic.tscn": 20},
        {"res://mobs/Basic.tscn": 30},
        {"res://mobs/Nyoom.tscn": 5},
        {"res://mobs/Basic.tscn": 50},
        {"res://mobs/Nyoom.tscn": 15},
        {"res://mobs/Basic.tscn": 75},
        {"res://mobs/FatOne.tscn": 10},
        {"res://mobs/Basic.tscn": 50, "res://mobs/Nyoom.tscn": 25},
        {"res://mobs/BigBoss.tscn": 1},
        {"res://mobs/Basic.tscn": 100},
        {"res://mobs/FatOne.tscn": 50},
        {"res://mobs/Nyoom.tscn": 100},
        {"res://mobs/FatOne.tscn": 100, "res://mobs/Nyoom.tscn": 100},
        {"res://mobs/BigBoss.tscn": 3},
        {"res://mobs/Basic.tscn": 250},
        {"res://mobs/FatOne.tscn": 250},
        {"res://mobs/Nyoom.tscn": 250},
        {"res://mobs/Basic.tscn": 200, "res://mobs/FatOne.tscn": 200},
        {"res://mobs/Basic.tscn": 200, "res://mobs/FatOne.tscn": 200, "res://mobs/Nyoom.tscn": 200},
    ]

func _ready():
    super._ready()
    start_wave()
