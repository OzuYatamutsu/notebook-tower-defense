class_name Missile
extends Projectile

const EXPLOSION_TIMER_SECS: float = 3.0

@onready var ExplosionTimer: Timer = $ExplosionTimer

func _ready() -> void:
    self.SPEED = 100.0
    self.DAMAGE = 50.0
    self.EFFECTS.append(Effect.new(self.effect))
    ExplosionTimer.wait_time = EXPLOSION_TIMER_SECS

func fire_at(mob: Mob) -> void:
    super.fire_at(mob)
    ExplosionTimer.start()

func _explode() -> void:
    pass

func effect(_mob: Mob) -> void:
    _explode()

func _on_explosion_timer_timeout() -> void:
    _explode()
