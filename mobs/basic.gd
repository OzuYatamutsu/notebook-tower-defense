class_name Basic
extends Mob

func _ready():
    self.HEALTH_BAR.set_max_hp(100.0)
    self.SPEED = 1000.0
    super._ready()
