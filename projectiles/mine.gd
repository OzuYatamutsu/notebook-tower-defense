class_name Mine
extends Mineable

const EXPLOSION_EFFECT_SCENE: PackedScene = preload("res://components/MineExplosion.tscn")

@onready var ProjectileRoot: Node2D = get_tree().get_first_node_in_group(GameState.PROJECTILES_GROUP)

var CurrentlyExploding: bool = false

func _ready() -> void:
    self.DAMAGE = 75.0
    self.EFFECTS.append(Effect.new(self.effect))

func _explode() -> void:
    if CurrentlyExploding:
        return
    CurrentlyExploding = true
    
    var explosion: MineExplosion = EXPLOSION_EFFECT_SCENE.instantiate()
    ProjectileRoot.add_child(explosion)
    explosion.global_position = global_position
    recycle()

func effect(_mob: Mob) -> void:
    call_deferred("_explode")
