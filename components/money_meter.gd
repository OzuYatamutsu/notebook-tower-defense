class_name MoneyMeter
extends Control

@onready var MoneyCountLabel: Label = $MoneyCountLabel

func update_value_text() -> void:
    MoneyCountLabel.text = "{0}".format([
        GameState.PLAYER_MONEY_REMAINING
    ])
