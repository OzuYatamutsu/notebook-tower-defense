class_name Wave
extends Node2D

# How many of each Mob should we spawn?
@export var WAVE_CONTENTS: Dictionary[Mob, int]
@export var CURRENT_WAVE_CONTENTS: Array[Mob]

func _init(wave_contents: Dictionary[Mob, int]) -> void:
    WAVE_CONTENTS = wave_contents
    for mob in WAVE_CONTENTS:
        for i in range(WAVE_CONTENTS[mob]):
            CURRENT_WAVE_CONTENTS.append(mob)
    CURRENT_WAVE_CONTENTS.shuffle()

func pop() -> Mob:
    return CURRENT_WAVE_CONTENTS.pop_front()

func is_empty() -> bool:
    return CURRENT_WAVE_CONTENTS.is_empty()
