class_name Level_Digestion
extends Level

func _init() -> void:
    WAVE_CONTENTS = [
        {"res://mobs/Basic.tscn": 5},
        {"res://mobs/Basic.tscn": 10},
        {"res://mobs/Nyoom.tscn": 5},
        {"res://mobs/Basic.tscn": 15},
        {"res://mobs/Nyoom.tscn": 15},
        {"res://mobs/Nyoom.tscn": 20},
        {"res://mobs/Nyoom.tscn": 25},
        {"res://mobs/Nyoom.tscn": 25, "res://mobs/Basic.tscn": 50},
        {"res://mobs/Nyoom.tscn": 25, "res://mobs/Basic.tscn": 50},
        {"res://mobs/Nyoom.tscn": 50, "res://mobs/Basic.tscn": 50},
        {"res://mobs/Nyoom.tscn": 100},
        {"res://mobs/Nyoom.tscn": 250},
        {"res://mobs/FatOne.tscn": 25, "res://mobs/Nyoom.tscn": 250},
        {"res://mobs/FatOne.tscn": 25, "res://mobs/Nyoom.tscn": 250},
        {"res://mobs/FatOne.tscn": 25, "res://mobs/Nyoom.tscn": 250},
        {"res://mobs/BigBoss.tscn": 5, "res://mobs/Nyoom.tscn": 500},
        {"res://mobs/BigBoss.tscn": 5, "res://mobs/Nyoom.tscn": 500},
        {"res://mobs/BigBoss.tscn": 5, "res://mobs/Nyoom.tscn": 500},
        {"res://mobs/BigBoss.tscn": 5, "res://mobs/FatOne.tscn": 100, "res://mobs/Nyoom.tscn": 600},
        {"res://mobs/BigBoss.tscn": 10, "res://mobs/FatOne.tscn": 110, "res://mobs/Nyoom.tscn": 600}
    ]

func _ready():
    super._ready()
    start_wave()
