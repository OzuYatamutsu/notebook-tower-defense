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
        {"res://mobs/Nyoom.tscn": 150},
        {"res://mobs/Basic.tscn": 50, "res://mobs/Nyoom.tscn": 200},
        {"res://mobs/Basic.tscn": 100, "res://mobs/Nyoom.tscn": 250},
        {"res://mobs/Basic.tscn": 250, "res://mobs/Nyoom.tscn": 500},
        {"res://mobs/BigBoss.tscn": 5, "res://mobs/Basic.tscn": 500, "res://mobs/Nyoom.tscn": 1000, "res://mobs/FatOne.tscn": 50},
        {"res://mobs/BigBoss.tscn": 5, "res://mobs/Basic.tscn": 500, "res://mobs/Nyoom.tscn": 2000, "res://mobs/FatOne.tscn": 75},
        {"res://mobs/BigBoss.tscn": 5, "res://mobs/Basic.tscn": 500, "res://mobs/Nyoom.tscn": 3000, "res://mobs/FatOne.tscn": 100},
        {"res://mobs/BigBoss.tscn": 5, "res://mobs/Basic.tscn": 500, "res://mobs/Nyoom.tscn": 4000, "res://mobs/FatOne.tscn": 125},
        {"res://mobs/BigBoss.tscn": 5, "res://mobs/Basic.tscn": 500, "res://mobs/Nyoom.tscn": 5000, "res://mobs/FatOne.tscn": 150},
        {"res://mobs/BigBoss.tscn": 5, "res://mobs/Basic.tscn": 500, "res://mobs/Nyoom.tscn": 6000, "res://mobs/FatOne.tscn": 175}

    ]

func _ready():
    super._ready()
    start_wave()
