class_name Level_Digestion
extends Level

func _init() -> void:
    WAVE_CONTENTS = [
        {"res://mobs/Nyoom.tscn": 5},
        {"res://mobs/Nyoom.tscn": 10},
        {"res://mobs/Nyoom.tscn": 15},
        {"res://mobs/Nyoom.tscn": 20},
        {"res://mobs/Nyoom.tscn": 25},
        {"res://mobs/Basic.tscn": 5, "res://mobs/Nyoom.tscn": 25},
        {"res://mobs/Basic.tscn": 10, "res://mobs/Nyoom.tscn": 25},
        {"res://mobs/Basic.tscn": 15, "res://mobs/Nyoom.tscn": 25},
        {"res://mobs/Basic.tscn": 20, "res://mobs/Nyoom.tscn": 25},
        {"res://mobs/Basic.tscn": 25, "res://mobs/Nyoom.tscn": 25},
        {"res://mobs/FatOne.tscn": 5, "res://mobs/Basic.tscn": 25, "res://mobs/Nyoom.tscn": 25},
        {"res://mobs/FatOne.tscn": 10, "res://mobs/Basic.tscn": 25, "res://mobs/Nyoom.tscn": 25},
        {"res://mobs/FatOne.tscn": 15, "res://mobs/Basic.tscn": 25, "res://mobs/Nyoom.tscn": 25},
        {"res://mobs/FatOne.tscn": 20, "res://mobs/Basic.tscn": 25, "res://mobs/Nyoom.tscn": 25},
        {"res://mobs/FatOne.tscn": 25, "res://mobs/Basic.tscn": 25, "res://mobs/Nyoom.tscn": 25},
        {"res://mobs/FatOne.tscn": 50, "res://mobs/Basic.tscn": 50, "res://mobs/Nyoom.tscn": 50},
        {"res://mobs/FatOne.tscn": 100, "res://mobs/Basic.tscn": 100, "res://mobs/Nyoom.tscn": 100},
        {"res://mobs/FatOne.tscn": 200, "res://mobs/Basic.tscn": 200, "res://mobs/Nyoom.tscn": 200},
        {"res://mobs/FatOne.tscn": 400, "res://mobs/Basic.tscn": 400, "res://mobs/Nyoom.tscn": 400},
        {"res://mobs/FatOne.tscn": 500, "res://mobs/Basic.tscn": 500, "res://mobs/Nyoom.tscn": 500},
    ]

func _ready():
    super._ready()
    start_wave()
