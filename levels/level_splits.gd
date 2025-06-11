class_name Level_Splits
extends Level

func _init() -> void:
    WAVE_CONTENTS = [
        {"res://mobs/Basic.tscn": 5},
        {"res://mobs/Basic.tscn": 10},
        {"res://mobs/Basic.tscn": 15},
        {"res://mobs/Basic.tscn": 15, "res://mobs/FatOne.tscn": 1},
        {"res://mobs/BigBoss.tscn": 1},
        {"res://mobs/Basic.tscn": 20, "res://mobs/FatOne.tscn": 10},
        {"res://mobs/Nyoom.tscn": 10},
        {"res://mobs/Basic.tscn": 10, "res://mobs/Nyoom.tscn": 10}
    ]

func _ready():
    super._ready()
    start_wave()
