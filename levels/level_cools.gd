class_name CoolS
extends Level

func _init() -> void:
    WAVE_CONTENTS = [
        {Basic: 5},
        {Basic: 10},
        {Basic: 15},
        {Basic: 15, FatOne: 1},
        {Basic: 15, FatOne: 2},
        {Basic: 20, FatOne: 3},
        {Basic: 25, FatOne: 4},
        {Basic: 30, FatOne: 5},
        {Basic: 35, FatOne: 6},
        {Basic: 35, BigBoss: 1},
        {Basic: 35, Nyoom: 5, FatOne: 6},
        {Basic: 35, Nyoom: 6, FatOne: 7},
        {Basic: 35, Nyoom: 7, FatOne: 8},
        {Basic: 35, Nyoom: 8, FatOne: 9},
        {Basic: 35, Nyoom: 9, FatOne: 10},
        {Basic: 50, Nyoom: 10, FatOne: 11},
        {Basic: 50, Nyoom: 11, FatOne: 12},
        {Basic: 50, Nyoom: 12, FatOne: 13},
        {Basic: 50, Nyoom: 13, FatOne: 14},
        {Basic: 50, Nyoom: 15, FatOne: 15, BigBoss: 1}
    ]

func _ready():
    super._ready()
    start_wave()
