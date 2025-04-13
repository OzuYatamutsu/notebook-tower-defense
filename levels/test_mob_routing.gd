extends PathFollow2D

const SPEED: float = 1000.0

func _physics_process(delta: float) -> void:
    set_progress(get_progress() + (delta * SPEED))
