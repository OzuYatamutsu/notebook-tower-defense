# class_name Respawner
extends Node

const MOB_INSTANCE_LIMIT = 10
const PROJECTILE_INSTANCE_LIMIT = 100

var MOB_TYPES = {
    Basic: preload("res://mobs/Basic.tscn"),
    BigBoss: preload("res://mobs/BigBoss.tscn"),
    FatOne: preload("res://mobs/FatOne.tscn"),
    Nyoom: preload("res://mobs/Nyoom.tscn")
}

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

@onready var MobRoot = get_tree().get_first_node_in_group(GameState.MOBS_GROUP)
@onready var ProjectileRoot: Node2D = get_tree().get_first_node_in_group(GameState.PROJECTILES_GROUP)

var ACTIVE_MOBS: Dictionary[GDScript, Array] = {}
var INACTIVE_MOBS: Dictionary[GDScript, Array] = {}
var MOB_COUNTS: Dictionary[GDScript, int] = {}
var ACTIVE_PROJECTILES: Dictionary[GDScript, Array] = {}
var INACTIVE_PROJECTILES: Dictionary[GDScript, Array] = {}
var PROJECTILE_COUNTS: Dictionary[GDScript, int] = {}

func _on_level_load():
    for projectile_type in ACTIVE_PROJECTILES:
        for projectile in ACTIVE_PROJECTILES[projectile_type]:
            projectile.queue_free()
    for mob_type in ACTIVE_MOBS:
        for mob in ACTIVE_MOBS[mob_type]:
            mob.queue_free()
    for projectile_type in INACTIVE_PROJECTILES:
        for projectile in INACTIVE_PROJECTILES[projectile_type]:
            projectile.queue_free()
    for mob_type in INACTIVE_MOBS:
        for mob in INACTIVE_MOBS[mob_type]:
            mob.queue_free()

    ACTIVE_MOBS = {}
    INACTIVE_MOBS = {}
    ACTIVE_PROJECTILES = {}
    INACTIVE_PROJECTILES = {}
    PROJECTILE_COUNTS = {}
    MOB_COUNTS = {}

    MobRoot = get_tree().get_first_node_in_group(GameState.MOBS_GROUP)
    ProjectileRoot = get_tree().get_first_node_in_group(GameState.PROJECTILES_GROUP)

func spawn_mob(mob_type: GDScript) -> Mob:
    var current_size = MOB_COUNTS.get(mob_type, 0)
    var mob = null
    
    if current_size == 0:
        mob = _new_spawn_mob(mob_type)
        ACTIVE_MOBS[mob_type] = [mob]
        MOB_COUNTS[mob_type] = 1
    elif current_size < MOB_INSTANCE_LIMIT:
        mob = _new_spawn_mob(mob_type)
        ACTIVE_MOBS[mob_type].append(mob)
        MOB_COUNTS[mob_type] += 1
    else:
        mob = _respawn_mob(mob_type)
    return mob

func spawn_projectile(projectile_type: GDScript) -> Projectile:
    var current_size = PROJECTILE_COUNTS.get(projectile_type, 0)
    var projectile = null

    if current_size == 0:
        projectile = _new_spawn_projectile(projectile_type)
        ACTIVE_PROJECTILES[projectile_type] = [projectile]
        PROJECTILE_COUNTS[projectile_type] = 1
    elif current_size < PROJECTILE_INSTANCE_LIMIT:
        projectile = _new_spawn_projectile(projectile_type)
        ACTIVE_PROJECTILES[projectile_type].append(projectile)
        PROJECTILE_COUNTS[projectile_type] += 1
    else:
        projectile = _respawn_projectile(projectile_type)
    return projectile

func recycle_mob(type: GDScript, mob: Mob) -> void:
    mob._deinit()

    # Remove pathing helper
    mob.move_child(MobRoot, 0)
    mob.get_parent().queue_free()

    var search_index = ACTIVE_MOBS[type].find(mob)
    if search_index == -1:
        return

    if type not in INACTIVE_MOBS:
        INACTIVE_MOBS[type] = []
    INACTIVE_MOBS[type].append(
        ACTIVE_MOBS[type][search_index]
    )
    ACTIVE_MOBS[type].erase(mob)

func recycle_projectile(type: GDScript, projectile: Projectile) -> void:
    projectile._deinit()

    var search_index = ACTIVE_PROJECTILES[type].find(projectile)
    if search_index == -1:
        return

    if type not in INACTIVE_PROJECTILES:
        INACTIVE_PROJECTILES[type] = []
    INACTIVE_PROJECTILES[type].append(
        ACTIVE_PROJECTILES[type][search_index]
    )
    ACTIVE_PROJECTILES[type].erase(projectile)

func _new_spawn_mob(mob_type: GDScript) -> Mob:
    # Spawn a new mob
    var new_mob = MOB_TYPES[mob_type].instantiate()
    var pathing_helper: MobPather = MobPather.new()

    pathing_helper.add_child(new_mob)
    MobRoot.get_random_mob_path().add_child(pathing_helper)

    new_mob._reinit()
    return new_mob

func _new_spawn_projectile(projectile_type: GDScript) -> Projectile:
    # Spawn a new projectile
    var new_projectile = PROJECTILE_TYPES[projectile_type].instantiate()
    ProjectileRoot.add_child(new_projectile)
    return new_projectile

func _respawn_mob(mob_type: GDScript) -> Mob:
    var new_mob = null

    if INACTIVE_MOBS.get(mob_type, []).size() > 0:
        new_mob = INACTIVE_MOBS[mob_type].pop_back()
    else:
        new_mob = ACTIVE_MOBS[mob_type].pop_front()
    
    if new_mob == null:
        new_mob = _new_spawn_mob(mob_type)
    ACTIVE_MOBS[mob_type].append(new_mob)

    var pathing_helper: MobPather = MobPather.new()
    new_mob.move_child(pathing_helper, 0)
    MobRoot.get_random_mob_path().add_child(pathing_helper)
    new_mob._reinit()
    return new_mob

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
