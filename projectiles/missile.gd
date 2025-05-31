class_name Missile
extends Projectile

const EXPLOSION_TIMER_SECS: float = 2.0
const EXPLOSION_EFFECT_SCENE: PackedScene = preload("res://components/MissileExplosion.tscn")

var CurrentlyExploding: bool = false

@onready var ProjectileRoot: Node2D = get_tree().get_first_node_in_group(GameState.PROJECTILES_GROUP)
@onready var ExplosionTimer: Timer = $ExplosionTimer

func _ready() -> void:
    self.SPEED = 100.0
    self.DAMAGE = 100.0
    self.EFFECTS.append(Effect.new(self.effect))
    ExplosionTimer.wait_time = EXPLOSION_TIMER_SECS

func fire_at(mob: Mob) -> void:
    super.fire_at(mob)
    rotation = direction.angle() + PI/2
    ExplosionTimer.start()

func _explode() -> void:
    if CurrentlyExploding:
        return
    CurrentlyExploding = true
    
    var explosion: MissileExplosion = EXPLOSION_EFFECT_SCENE.instantiate()
    ProjectileRoot.add_child(explosion)
    explosion.global_position = global_position
    queue_free()

func effect(_mob: Mob) -> void:
    _explode()

func _on_explosion_timer_timeout() -> void:
    _explode()
