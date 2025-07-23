class_name MoneyMeter
extends Control

var MoneyCount: int = 0

@onready var MoneyCountLabel: Label = $MoneyCountLabel

func set_value(value: int) -> void:
    MoneyCount = value

func _set_text() -> void:
    MoneyCountLabel.text = "{0}".format([MoneyCount])
