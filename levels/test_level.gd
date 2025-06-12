class_name Easy_Street
extends Level

func _init() -> void:
    WAVE_CONTENTS = [
        {"res://mobs/Basic.tscn": 5},
        {"res://mobs/Basic.tscn": 10},
        {"res://mobs/Basic.tscn": 15},
        {"res://mobs/FatOne.tscn": 10},
        {"res://mobs/Basic.tscn": 30},
        {"res://mobs/Nyoom.tscn": 5},
        {"res://mobs/FatOne.tscn": 20},
        {"res://mobs/Basic.tscn": 20, "res://mobs/Nyoom.tscn": 20},
        {"res://mobs/Basic.tscn": 75},
        {"res://mobs/FatOne.tscn": 20, "res://mobs/BigBoss.tscn": 1},
        {"res://mobs/Nyoom.tscn": 30},
        {"res://mobs/FatOne.tscn": 50},
        {"res://mobs/Basic.tscn": 100, "res://mobs/Nyoom.tscn": 30},
        {"res://mobs/Basic.tscn": 100, "res://mobs/FatOne.tscn": 20},
        {"res://mobs/Basic.tscn": 100, "res://mobs/FatOne.tscn": 30, "res://mobs/Nyoom.tscn": 20},
        {"res://mobs/Basic.tscn": 150, "res://mobs/FatOne.tscn": 30, "res://mobs/Nyoom.tscn": 20},
        {"res://mobs/Basic.tscn": 150, "res://mobs/FatOne.tscn": 30, "res://mobs/Nyoom.tscn": 20},
        {"res://mobs/Basic.tscn": 200, "res://mobs/FatOne.tscn": 50, "res://mobs/Nyoom.tscn": 50},
        {"res://mobs/BigBoss.tscn": 5},
        {"res://mobs/BigBoss.tscn": 5, "res://mobs/Basic.tscn": 100, "res://mobs/FatOne.tscn": 100, "res://mobs/Nyoom.tscn": 100}
    ]

    GameState.PLAYER_MONEY_REMAINING = 200

func _ready():
    super._ready()
    start_wave()
