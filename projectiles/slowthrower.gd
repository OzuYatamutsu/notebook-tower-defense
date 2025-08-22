class_name Slowthrower
extends Projectile

var SLOW_COLOR_SHADER = load("res://components/tint_blue.gdshader")
var SLOW_COLOR_SHADER_MATERIAL = ShaderMaterial.new()

func _ready() -> void:
    self.SPEED = 300.0
    self.DAMAGE = 0.1
    self.EFFECTS.append(Effect.new(self.effect))
    SLOW_COLOR_SHADER_MATERIAL.shader = SLOW_COLOR_SHADER

func effect(mob: Mob) -> void:
    if mob.SPEED > Mob.MIN_SPEED:
        mob.SPEED *= 0.98
    mob.SPRITE.material = SLOW_COLOR_SHADER_MATERIAL
