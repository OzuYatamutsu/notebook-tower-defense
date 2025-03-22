class_name Wave
extends Node2D

signal wave_started
signal wave_ended

# How many of each Mob should we spawn?
@export var WAVE_CONTENTS: Dictionary[Mob, int]

func _init(wave_contents: Dictionary[Mob, int]) -> void:
    WAVE_CONTENTS = wave_contents

func start_wave() -> void:
    emit_signal(wave_started.get_name())

func end_wave() -> void:
    emit_signal(wave_ended.get_name())
