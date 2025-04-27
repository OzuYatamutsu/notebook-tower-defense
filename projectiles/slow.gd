class_name Slow
extends Projectile

var SLOW_COLOR_SHADER = load("res://components/tint_blue.gdshader")
var SLOW_COLOR_SHADER_MATERIAL = ShaderMaterial.new()

func _ready() -> void:
    self.SPEED = 2000.0
    self.DAMAGE = 1.0
    self.EFFECTS.append(Effect.new(self.effect))
    SLOW_COLOR_SHADER_MATERIAL.shader = SLOW_COLOR_SHADER

func effect(mob: Mob) -> void:
    mob.SPEED *= 0.60
    mob.SPRITE.material = SLOW_COLOR_SHADER_MATERIAL
