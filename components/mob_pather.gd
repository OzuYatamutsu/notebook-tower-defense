class_name MobPather
extends PathFollow2D

var SPEED: float

func _init(speed: float):
    assert(speed > 0.0, "Speed must be positive!")
    self.SPEED = speed
    rotates = false  # hack

func _physics_process(delta: float) -> void:
    if progress_ratio >= 100.0:
        progress_ratio = 100.0
        return
    progress_ratio += SPEED * delta

func _on_mob_despawn(_mob) -> void:
    queue_free()
