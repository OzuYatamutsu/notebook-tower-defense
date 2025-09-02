class_name Level_Fe_Lite
extends Level

func _init() -> void:
    WAVE_CONTENTS = [
        {Basic: 10},
        {Basic: 20},
        {Basic: 30, FatOne: 10},
        {Nyoom: 20},
        {Basic: 50, FatOne: 50},
        {FatOne: 100, BigBoss: 1},
        {Basic: 75, FatOne: 100, BigBoss: 1},
        {Basic: 75, FatOne: 150, BigBoss: 1},
        {Nyoom: 50},
        {BigBoss: 5},
        {FatOne: 200},
        {FatOne: 400, BigBoss: 5},
        {Nyoom: 100},
        {FatOne: 500, BigBoss: 5},
        {BigBoss: 20},
        {Basic: 500},
        {Basic: 1000, FatOne: 500},
        {Nyoom: 250, FatOne: 500},
        {Basic: 1000, FatOne: 1000, Nyoom: 200},
        {Basic: 1000, FatOne: 1000, Nyoom: 200, BigBoss: 50},
    ]

func _ready():
    super._ready()
    start_wave()
