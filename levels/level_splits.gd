class_name Level_Splits
extends Level

func _init() -> void:
    WAVE_CONTENTS = [
        {Basic: 10},
        {Basic: 10},
        {Nyoom: 10},
        {Nyoom: 5},
        {BigBoss: 1},
        {Basic: 10, FatOne: 10},
        {Basic: 15},
        {Nyoom: 10},
        {BigBoss: 1, FatOne: 10},
        {FatOne: 25},
        {Basic: 25},
        {FatOne: 25},
        {Nyoom: 20, Basic: 50},
        {Nyoom: 20, FatOne: 25},
        {Basic: 35, Nyoom: 20, FatOne: 35},
        {Basic: 50},
        {FatOne: 50},
        {Basic: 35, Nyoom: 35, FatOne: 35},
        {BigBoss: 1, Basic: 35, Nyoom: 35, FatOne: 35},
        {Basic: 55, Nyoom: 55, FatOne: 55},
    ]

func _ready():
    super._ready()
    start_wave()
