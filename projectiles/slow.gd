class_name Slow
extends Projectile

const SLOW_COLOR = Color("02CAF6")

func _ready() -> void:
    self.SPEED = 1000.0
    self.DAMAGE = 1.0
    self.EFFECTS.append(Effect.new(self.effect))

func effect(mob: Mob) -> void:
    mob.SPEED *= 0.25
    mob.SPRITE.modulate = SLOW_COLOR
