class_name Level_Switchback
extends Level

func _init() -> void:
    WAVE_CONTENTS = [
        {"res://mobs/Basic.tscn": 5},
        {"res://mobs/Nyoom.tscn": 5},
        {"res://mobs/Nyoom.tscn": 10},
        {"res://mobs/Nyoom.tscn": 25},
        {"res://mobs/Nyoom.tscn": 50},
        {"res://mobs/Basic.tscn": 50},
        {"res://mobs/Basic.tscn": 50, "res://mobs/Nyoom.tscn": 50},
        {"res://mobs/FatOne.tscn": 50},
        {"res://mobs/FatOne.tscn": 50, "res://mobs/Nyoom.tscn": 50},
        {"res://mobs/BigBoss.tscn": 3},
        {"res://mobs/Nyoom.tscn": 100},
        {"res://mobs/Basic.tscn": 50, "res://mobs/Nyoom.tscn": 150},
        {"res://mobs/Basic.tscn": 100, "res://mobs/Nyoom.tscn": 200},
        {"res://mobs/Basic.tscn": 250, "res://mobs/Nyoom.tscn": 250},
        {"res://mobs/Basic.tscn": 500, "res://mobs/Nyoom.tscn": 500, "res://mobs/FatOne.tscn": 50}
    ]

func _ready():
    super._ready()
    start_wave()
