class_name Win
extends Control

@onready var ScoreCounter = $ScoreCounter

func _ready() -> void:
    GameState.SHOULDNT_PAUSE = true
    set_score(GameState.SCORE)

func set_score(value: int):
    ScoreCounter.text = "Score: " + str(value)

func _on_restart_button_pressed() -> void:
    GameState.restart_game()

func _on_quit_button_pressed() -> void:
    GameState.quit_game()
