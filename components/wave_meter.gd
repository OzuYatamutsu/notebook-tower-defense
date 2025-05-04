class_name WaveMeter
extends Control

@onready var one_digit_control = $one_digit
@onready var two_digit_control = $two_digit

@onready var one_digit_digit1 = $one_digit/digit1
@onready var two_digit_digit1 = $two_digit/digit1
@onready var two_digit_digit2 = $two_digit/digit2
@onready var total_digit1 = $of_total/digit1
@onready var total_digit2 = $of_total/digit2

@onready var WaveTimerUI: TimeBar = $WaveTimerUI

const CLEAR_DIGIT = 10

func set_value(value: int) -> void:
    one_digit_digit1.frame = CLEAR_DIGIT
    two_digit_digit1.frame = CLEAR_DIGIT
    two_digit_digit2.frame = CLEAR_DIGIT
    
    if value <= 0:
        value = 0
    elif value >= 99:
        value = 99
    
    if value < 10:
        _set_value_one_digit(value)
    else:
        _set_value_two_digit(value)

func _set_value_one_digit(value: int) -> void:
    one_digit_digit1.frame = value

func _set_value_two_digit(value: int) -> void:
    var str_value = str(value)
    var length = str_value.length()

    # Alignment
    var start_index = 2 - length

    for i in range(length):
        var digit = int(str_value[i])
        match start_index + i:
            0: two_digit_digit1.frame = digit
            1: two_digit_digit2.frame = digit

func set_max_value(value: int) -> void:
    total_digit1.frame = CLEAR_DIGIT
    total_digit1.frame = CLEAR_DIGIT
    
    if value <= 0:
        value = 0
    elif value >= 99:
        value = 99

    var str_value = str(value)
    var length = str_value.length()

    # Alignment
    var start_index = 2 - length

    for i in range(length):
        var digit = int(str_value[i])
        match start_index + i:
            0: total_digit1.frame = digit
            1: total_digit2.frame = digit
