class_name WaveMeter
extends Control

@onready var WavesCountLabel: Label = $TimeBar/WavesCountLabel
@onready var WaveTimerUI: TimeBar = $TimeBar

func _process(_delta) -> void:
    _update_color()

func update_value_text() -> void:
    WavesCountLabel.text = "{0}/{1}".format([
        GameState.CURRENT_LEVEL.CURRENT_WAVE,
        len(GameState.CURRENT_LEVEL.WAVE_CONTENTS)
    ])

func _update_color() -> void:
    # Set the color of the label based on what percentage of
    # the current wave has elapsed.
    WavesCountLabel.add_theme_color_override(
        "font_color",
        Color(
            clamp(WaveTimerUI.get_timer_percent(), 0.0, 1.0),
            clamp(WaveTimerUI.get_timer_percent(), 0.0, 1.0),
            clamp(WaveTimerUI.get_timer_percent(), 0.0, 1.0),
        )
    )
