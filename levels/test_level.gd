class_name Easy_Street
extends Level

func _init() -> void:
    WAVE_CONTENTS = [
        {Basic: 5},
        {Basic: 10},
        {Basic: 15},
        {FatOne: 10},
        {Basic: 30},
        {Nyoom: 5, Basic: 15},
        {FatOne: 20},
        {Basic: 20, Nyoom: 20},
        {Basic: 75},
        {FatOne: 20, BigBoss: 1},
        {Nyoom: 30},
        {FatOne: 50},
        {Basic: 100, Nyoom: 30},
        {Basic: 100, FatOne: 20},
        {Basic: 100, FatOne: 30, Nyoom: 20},
        {Basic: 150, FatOne: 30, Nyoom: 20},
        {Basic: 150, FatOne: 30, Nyoom: 20},
        {Basic: 200, FatOne: 50, Nyoom: 50},
        {BigBoss: 5},
        {BigBoss: 5, Basic: 100, FatOne: 100, Nyoom: 100}
    ]

func _ready():
    super._ready()
    start_wave()
