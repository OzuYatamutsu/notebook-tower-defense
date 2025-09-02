class_name PoisonSpike
extends Mineable

const POISON_DAMAGE_PER_TICK: float = 2.5
const POISON_TIMER_TICK_SECS = 0.25

var SLOW_COLOR_SHADER = load("res://components/tint_green.gdshader")
var SLOW_COLOR_SHADER_MATERIAL = ShaderMaterial.new()

func _ready() -> void:
    self.DAMAGE = 10.0
    self.EFFECTS.append(Effect.new(self.poison_effect))
    self.EFFECTS.append(Effect.new(self.slow_effect))
    SLOW_COLOR_SHADER_MATERIAL.shader = SLOW_COLOR_SHADER

func poison_effect(mob: Mob) -> void:
    call_deferred("_poison", mob)

func slow_effect(mob: Mob) -> void:
    call_deferred("_slow", mob)

func _slow(mob: Mob) -> void:
    mob.SPEED *= 0.60
    mob.SPRITE.material = SLOW_COLOR_SHADER_MATERIAL

func _poison(mob: Mob) -> void:
    # Add a POISON TIMER to the mob
    var poison_timer = Timer.new()
    poison_timer.wait_time = POISON_TIMER_TICK_SECS

    mob.add_child(poison_timer)
    poison_timer.timeout.connect(
        func(): mob.HEALTH_BAR.damage_by(POISON_TIMER_TICK_SECS)
    )
    poison_timer.start()
