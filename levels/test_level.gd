class_name Easy_Street
extends Level

func _init() -> void:
    WAVE_CONTENTS = [
        {"res://mobs/Basic.tscn": 5},
        {"res://mobs/Basic.tscn": 10},
        {"res://mobs/Basic.tscn": 15},
        {"res://mobs/FatOne.tscn": 10},
        {"res://mobs/Basic.tscn": 15, "res://mobs/FatOne.tscn": 5},
        {"res://mobs/BigBoss.tscn": 1},
        {"res://mobs/Nyoom.tscn": 5},
        {"res://mobs/Basic.tscn": 30, "res://mobs/FatOne.tscn": 10},
        {"res://mobs/Basic.tscn": 30, "res://mobs/Nyoom.tscn": 10, "res://mobs/FatOne.tscn": 5}
    ]
    
    GameState.PLAYER_MONEY_REMAINING = 1000

func _ready():
    super._ready()
    start_wave()
