class_name MoneyMeter
extends Control

const NUM_DIGITS = 6

@onready var MoneyCountLabel: Label = $MoneyCountLabel

func update_value_text() -> void:
    MoneyCountLabel.text = _zero_pad("{0}".format([
        GameState.PLAYER_MONEY_REMAINING
    ]))

func _zero_pad(num_text: String) -> String:
    var num_digits_to_add = NUM_DIGITS - num_text.length()
    if num_digits_to_add <= 0:
        return num_text
    return ('0' * num_digits_to_add) + num_text
