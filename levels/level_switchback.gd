class_name Level_Switchback
extends Level

func _init() -> void:
    WAVE_CONTENTS = [
        {Basic: 5},
        {Nyoom: 5},
        {Nyoom: 10},
        {Nyoom: 25},
        {Nyoom: 50},
        {Basic: 50},
        {Basic: 50, Nyoom: 50},
        {FatOne: 50},
        {FatOne: 50, Nyoom: 50},
        {BigBoss: 3},
        {Nyoom: 150},
        {Basic: 50, Nyoom: 200},
        {Basic: 100, Nyoom: 250},
        {Basic: 250, Nyoom: 500},
        {BigBoss: 5, Basic: 500, Nyoom: 1000, FatOne: 50},
        {BigBoss: 5, Basic: 500, Nyoom: 2000, FatOne: 75},
        {BigBoss: 5, Basic: 500, Nyoom: 3000, FatOne: 100},
        {BigBoss: 5, Basic: 500, Nyoom: 4000, FatOne: 125},
        {BigBoss: 5, Basic: 500, Nyoom: 5000, FatOne: 150},
        {BigBoss: 5, Basic: 500, Nyoom: 6000, FatOne: 175}
    ]

func _ready():
    super._ready()
    start_wave()
