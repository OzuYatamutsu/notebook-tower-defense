class_name Level_Digestion
extends Level

func _init() -> void:
    WAVE_CONTENTS = [
        {Basic: 5},
        {Basic: 10},
        {Nyoom: 5},
        {Basic: 15},
        {Nyoom: 15},
        {Nyoom: 20},
        {Nyoom: 25},
        {Nyoom: 25, Basic: 50},
        {Nyoom: 25, Basic: 50},
        {Nyoom: 50, Basic: 50},
        {Nyoom: 100},
        {Nyoom: 250},
        {FatOne: 25, Nyoom: 250},
        {FatOne: 25, Nyoom: 250},
        {FatOne: 25, Nyoom: 250},
        {BigBoss: 5, Nyoom: 500},
        {BigBoss: 5, Nyoom: 500},
        {BigBoss: 5, Nyoom: 500},
        {BigBoss: 5, FatOne: 100, Nyoom: 600},
        {BigBoss: 10, FatOne: 110, Nyoom: 600}
    ]

func _ready():
    super._ready()
    start_wave()
