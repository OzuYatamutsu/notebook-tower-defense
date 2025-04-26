class_name Slow
extends Projectile

func _ready() -> void:
    self.SPEED = 1000.0
    self.DAMAGE = 1.0

func _physics_process(_delta: float) -> void:
    if !IS_ACTIVE:
        return
