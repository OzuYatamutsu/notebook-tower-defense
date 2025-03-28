class_name Arrow
extends Projectile

func _ready() -> void:
    self.SPEED = 300.0
    self.DAMAGE = 50.0

func _physics_process(_delta: float) -> void:
    if !IS_ACTIVE:
        return
    
    # We want to point the head of the arrow at
    # what we're firing
    look_at(TARGET.global_position)
