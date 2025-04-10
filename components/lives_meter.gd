class_name LivesMeter
extends Control

@onready var digit1 = $digit1
@onready var digit2 = $digit2

const CLEAR_DIGIT = 10

func set_value(value: int):
    digit1.frame = CLEAR_DIGIT
    digit2.frame = CLEAR_DIGIT
    
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
            0: digit1.frame = digit
            1: digit2.frame = digit
