class_name MobPather
extends PathFollow2D

var SPEED: float

func _init(speed: float):
    assert(speed > 0.0, "Speed must be positive!")
    self.SPEED = speed
    rotates = false  # hack

func _physics_process(delta: float) -> void:
    progress_ratio += SPEED * delta

func _on_mob_despawn() -> void:
    queue_free()
