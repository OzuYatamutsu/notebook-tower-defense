class_name Missile
extends Projectile

const EXPLOSION_TIMER_SECS: float = 3.0
const EXPLOSION_EFFECT_SCENE: PackedScene = preload("res://components/MissileExplosion.tscn")

var CurrentlyExploding: bool = false

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
    if CurrentlyExploding:
        return
    CurrentlyExploding = true
    get_tree().add_child(EXPLOSION_EFFECT_SCENE.instantiate())
    queue_free()

func effect(_mob: Mob) -> void:
    _explode()

func _on_explosion_timer_timeout() -> void:
    _explode()
