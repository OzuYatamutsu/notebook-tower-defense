class_name MoneyMeter
extends Control

@onready var digit1 = $digit1
@onready var digit2 = $digit2
@onready var digit3 = $digit3
@onready var digit4 = $digit4
@onready var digit5 = $digit5

const CLEAR_DIGIT = 10

func set_value(value: int):
    digit1.frame = CLEAR_DIGIT
    digit2.frame = CLEAR_DIGIT
    digit3.frame = CLEAR_DIGIT
    digit4.frame = CLEAR_DIGIT
    digit5.frame = CLEAR_DIGIT
    
    if value <= 0:
        value = 0

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
