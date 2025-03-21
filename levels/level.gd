class_name Level
extends Node

func _ready() -> void:
    GameState.PLAYER_LIVES_START = 5  # TODO
    GameState._on_level_load()
