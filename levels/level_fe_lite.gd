class_name Level_Fe_Lite
extends Level

func _init() -> void:
    WAVE_CONTENTS = [
        {"res://mobs/Basic.tscn": 10},
        {"res://mobs/Basic.tscn": 20},
        {"res://mobs/Basic.tscn": 30, "res://mobs/FatOne.tscn": 10},
        {"res://mobs/Nyoom.tscn": 20},
        {"res://mobs/Basic.tscn": 50, "res://mobs/FatOne.tscn": 50},
        {"res://mobs/FatOne.tscn": 100, "res://mobs/BigBoss.tscn": 1},
        {"res://mobs/Basic.tscn": 75, "res://mobs/FatOne.tscn": 100, "res://mobs/BigBoss.tscn": 1},
        {"res://mobs/Basic.tscn": 75, "res://mobs/FatOne.tscn": 150, "res://mobs/BigBoss.tscn": 1},
        {"res://mobs/Nyoom.tscn": 50},
        {"res://mobs/BigBoss.tscn": 5},
        {"res://mobs/FatOne.tscn": 200},
        {"res://mobs/FatOne.tscn": 400, "res://mobs/BigBoss.tscn": 5},
        {"res://mobs/Nyoom.tscn": 100},
        {"res://mobs/FatOne.tscn": 500, "res://mobs/BigBoss.tscn": 10},
        {"res://mobs/BigBoss.tscn": 35},
        {"res://mobs/Basic.tscn": 500},
        {"res://mobs/Basic.tscn": 1000, "res://mobs/FatOne.tscn": 500},
        {"res://mobs/Nyoom.tscn": 250, "res://mobs/FatOne.tscn": 500},
        {"res://mobs/Basic.tscn": 1000, "res://mobs/FatOne.tscn": 1000, "res://mobs/Nyoom.tscn": 200},
        {"res://mobs/Basic.tscn": 1000, "res://mobs/FatOne.tscn": 1000, "res://mobs/Nyoom.tscn": 200, "res://mobs/BigBoss.tscn": 100},
    ]

func _ready():
    super._ready()
    start_wave()
