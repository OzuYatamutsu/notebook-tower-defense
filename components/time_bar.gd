class_name TimeBar
extends Node2D

# fired when time=0
signal no_time

const TIME_BAR_MAX_WIDTH = 400.0
const TIME_BAR_MAX_HEIGHT = 65.0

# How often should we update the UI?
const TIMER_TICK_SECS = 0.2

@onready var TimeBarSprite: Sprite2D = $TimeBarFullSprite
@onready var TickTimer: Timer = $TickTimer

var MAX_TIME_SECS: float
var TIME_SECS: float

func set_max_time(max_time_secs: float) -> void:
    MAX_TIME_SECS = max_time_secs
    TIME_SECS = max_time_secs

func update_time_bar() -> void:
    TimeBarSprite.region_rect.size = Vector2(
        TIME_BAR_MAX_WIDTH * (TIME_SECS / MAX_TIME_SECS),
        TIME_BAR_MAX_HEIGHT
    )

func reset_timer() -> void:
    TIME_SECS = MAX_TIME_SECS

func enable() -> void:
    TickTimer.start()

func disable() -> void:
    TickTimer.stop()

func _on_tick_timer_timeout() -> void:
    TIME_SECS -= TIMER_TICK_SECS

    update_time_bar()
    
    if TIME_SECS <= 0.0:
        TIME_SECS = 0.0
        no_time.emit()
        disable()
