class_name Level
extends Node

var WAVE_CONTENTS: Array[Dictionary]
var WAVES: Array[Wave] = []

func _ready() -> void:
    GameState.PLAYER_LIVES_START = 5  # TODO
    for wave_contents in WAVE_CONTENTS:
        WAVES.append(Wave.new(wave_contents))
    GameState._on_level_load()
