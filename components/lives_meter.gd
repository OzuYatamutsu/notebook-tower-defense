class_name LivesMeter
extends Control

var LivesNum: int = 0

@onready var LivesCountLabel: Label = $LivesCountLabel

func set_value(current_lives_num: int) -> void:
    LivesNum = current_lives_num

func _set_text() -> void:
    LivesCountLabel.text = "{0}".format([LivesNum])
