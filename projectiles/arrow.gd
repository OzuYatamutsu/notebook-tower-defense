class_name Arrow
extends Projectile

func _ready() -> void:
    self.SPEED = 100.0

func _physics_process(delta: float) -> void:
    if !IS_ACTIVE:
        return
    
    # We want to point the head of the arrow at
    # what we're firing
    rotation = position.angle_to_point(TARGET_LOCATION)
