extends Level

func _init() -> void:
    WAVE_CONTENTS = [
        {"res://mobs/Basic.tscn": 5},
        {"res://mobs/Basic.tscn": 15},
    ]

func _ready():
    super._ready()
    start_wave()
