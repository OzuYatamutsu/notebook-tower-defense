class_name Bullet
extends Projectile

func _ready() -> void:
    self.SPEED = 300.0
    self.DAMAGE = 50.0

func _physics_process(_delta: float) -> void:
    if !IS_ACTIVE:
        return
