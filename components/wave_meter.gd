class_name WaveMeter
extends Control

var WaveNum: int = 0
var MaxWaveNum: int = 0

@onready var WaveMeterLabel: Label = $Label
@onready var WaveTimerUI: TimeBar = $WaveTimerUI

func _process(_delta) -> void:
    _update_color()

func set_value(current_wave_num: int) -> void:
    WaveNum = current_wave_num

func set_max_value(max_wave_num: int) -> void:
    MaxWaveNum = max_wave_num

func _set_text() -> void:
    WaveMeterLabel.text = "{0}/{1}".format([WaveNum, MaxWaveNum])

func _update_color() -> void:
    # Set the color of the label based on what percentage of
    # the current wave has elapsed.
    WaveMeterLabel.add_theme_color_override(
        "font_color",
        clamp(WaveTimerUI.get_timer_percent(), 0.0, 1.0)
    )
