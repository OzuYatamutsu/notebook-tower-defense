class_name Wave
extends Node2D

signal wave_started
signal wave_ended

# How much money should we grant at the end of
# each wave?
const WAVE_END_MONEY_BONUS: int = 200

# How many of each Mob should we spawn?
@export var WAVE_CONTENTS: Dictionary  # [GDScript, int]
@export var CURRENT_WAVE_CONTENTS: Array[GDScript]

func _init(wave_contents: Dictionary) -> void:
    WAVE_CONTENTS = wave_contents
    for mob in WAVE_CONTENTS:
        for i in range(WAVE_CONTENTS[mob]):
            CURRENT_WAVE_CONTENTS.append(mob)
    CURRENT_WAVE_CONTENTS.shuffle()

func start() -> void:
    emit_signal(wave_started.get_name())

func end() -> void:
    emit_signal(wave_ended.get_name())

func pop() -> Mob:
    return Respawner.spawn_mob(CURRENT_WAVE_CONTENTS.pop_front())

func is_empty() -> bool:
    return CURRENT_WAVE_CONTENTS.is_empty()
