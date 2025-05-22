class_name SniperBullet
extends Projectile

func _ready() -> void:
    self.SPEED = 750.0
    self.DAMAGE = 150.0

func _physics_process(_delta: float) -> void:
    if !IS_ACTIVE:
        return
    
    # We want to point the head of the bullet at
    # what we're firing
    look_at(TARGET.global_position)
