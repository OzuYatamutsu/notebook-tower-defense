class_name Win
extends Control

const CLEAR_DIGIT = 10

@onready var digit1 = $VBoxContainer/Score/digit1
@onready var digit2 = $VBoxContainer/Score/digit2
@onready var digit3 = $VBoxContainer/Score/digit3
@onready var digit4 = $VBoxContainer/Score/digit4
@onready var digit5 = $VBoxContainer/Score/digit5
@onready var digit6 = $VBoxContainer/Score/digit6
@onready var digit7 = $VBoxContainer/Score/digit7

func _ready() -> void:
    set_score(GameState.SCORE)

func set_score(value: int):
    digit1.frame = CLEAR_DIGIT
    digit2.frame = CLEAR_DIGIT
    digit3.frame = CLEAR_DIGIT
    digit4.frame = CLEAR_DIGIT
    digit5.frame = CLEAR_DIGIT
    digit6.frame = CLEAR_DIGIT
    digit7.frame = CLEAR_DIGIT
    
    if value <= 0:
        value = 0
    elif value >= 9999999:
        value = 9999999

    var str_value = str(value)
    var length = str_value.length()

    # Alignment
    var start_index = 5 - length

    for i in range(length):
        var digit = int(str_value[i])
        match start_index + i:
            0: digit1.frame = digit
            1: digit2.frame = digit
            2: digit3.frame = digit
            3: digit4.frame = digit
            4: digit5.frame = digit
            5: digit6.frame = digit
            6: digit7.frame = digit

func _on_restart_button_pressed() -> void:
    GameState.restart_game()

func _on_quit_button_pressed() -> void:
    GameState.quit_game()
