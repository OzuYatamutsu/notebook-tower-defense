# class_name Respawner
extends Node

const MOB_INSTANCE_LIMIT = 300
const PROJECTILE_INSTANCE_LIMIT = 100

var PROJECTILE_TYPES = {
    Bullet: preload("res://projectiles/Bullet.tscn"),
    FastLaser: preload("res://projectiles/FastLaser.tscn"),
    HeavyLaser: preload("res://projectiles/HeavyLaser.tscn"),
    Laser: preload("res://projectiles/Laser.tscn"),
    Mine: preload("res://projectiles/Mine.tscn"),
    Mineable: null,
    Missile: preload("res://projectiles/Missile.tscn"),
    PoisonSpike: preload("res://projectiles/PoisonSpike.tscn"),
    Slow: preload("res://projectiles/Slow.tscn"),
    Slowthrower: preload("res://projectiles/Slowthrower.tscn"),
    SniperBullet: preload("res://projectiles/SniperBullet.tscn"),
    Spike: preload("res://projectiles/Spike.tscn")
}

@onready var ProjectileRoot: Node2D = get_tree().get_first_node_in_group(GameState.PROJECTILES_GROUP)

var MOB_SPAWNER = {}
var ACTIVE_PROJECTILES: Dictionary[GDScript, Array] = {}
var INACTIVE_PROJECTILES: Dictionary[GDScript, Array] = {}
var PROJECTILE_COUNTS: Dictionary[GDScript, int] = {}

func _on_level_load():
    for projectile_type in ACTIVE_PROJECTILES:
        for projectile in ACTIVE_PROJECTILES[projectile_type]:
            projectile.queue_free()
    ACTIVE_PROJECTILES = {}
    for projectile_type in INACTIVE_PROJECTILES:
        for projectile in INACTIVE_PROJECTILES[projectile_type]:
            projectile.queue_free()
    INACTIVE_PROJECTILES = {}
    PROJECTILE_COUNTS = {}
    ProjectileRoot = get_tree().get_first_node_in_group(GameState.PROJECTILES_GROUP)

func spawn_projectile(projectile_type: GDScript) -> Projectile:
    var current_size = PROJECTILE_COUNTS.get(projectile_type, 0)
    var inactive_size = INACTIVE_PROJECTILES.get(projectile_type, []).size()
    var projectile = null

    if current_size == 0:
        projectile = _new_spawn_projectile(projectile_type)
        ACTIVE_PROJECTILES[projectile_type] = [projectile]
        PROJECTILE_COUNTS[projectile_type] = 1
    elif inactive_size >= PROJECTILE_INSTANCE_LIMIT:
        projectile = _respawn_projectile(projectile_type)
    elif current_size < PROJECTILE_INSTANCE_LIMIT:
        projectile = _new_spawn_projectile(projectile_type)
        ACTIVE_PROJECTILES[projectile_type].append(projectile)
        PROJECTILE_COUNTS[projectile_type] += 1
    else:
        projectile = _respawn_projectile(projectile_type)
    return projectile

func recycle_projectile(type: GDScript, projectile: Projectile) -> void:
    projectile._deinit()

    var find_index = ACTIVE_PROJECTILES[type].find(projectile)
    if find_index == -1:
        return

    if type not in INACTIVE_PROJECTILES:
        INACTIVE_PROJECTILES[type] = []
    INACTIVE_PROJECTILES[type].append(
        ACTIVE_PROJECTILES[type][find_index]
    )
    ACTIVE_PROJECTILES[type].erase(projectile)

func _new_spawn_projectile(projectile_type: GDScript) -> Projectile:
    # Spawn a new projectile
    var new_projectile = PROJECTILE_TYPES[projectile_type].instantiate()
    ProjectileRoot.add_child(new_projectile)
    return new_projectile

func _respawn_projectile(projectile_type: GDScript) -> Projectile:
    var new_projectile = null

    if INACTIVE_PROJECTILES.get(projectile_type, []).size() > 0:
        new_projectile = INACTIVE_PROJECTILES[projectile_type].pop_back()
    else:
        new_projectile = ACTIVE_PROJECTILES[projectile_type].pop_front()
    
    if new_projectile == null:
        new_projectile = _new_spawn_projectile(projectile_type)
    ACTIVE_PROJECTILES[projectile_type].append(new_projectile)

    new_projectile._init()
    return new_projectile
