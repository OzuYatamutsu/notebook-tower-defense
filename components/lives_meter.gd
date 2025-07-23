class_name LivesMeter
extends Control

@onready var LivesCountLabel: Label = $LivesCountLabel

func update_value_text() -> void:
    LivesCountLabel.text = "{0}".format([
        GameState.PLAYER_LIVES_REMAINING
    ])
