class_name LevelSpawn
extends Area2D

signal spawn_mob

# How far off from global_position can we spawn the enemy?
# 0 = on spawn, enemy position = our global_position
# 1 = on spawn, enemy position = anywhere *up to* 2x global_position
const WIGGLE_ROOM_PERCENT: float = 0.05

@export var SPAWN_TIMER_SECS: float = 0.5

@onready var SpawnTimer = $SpawnTimer

func _ready() -> void:
    SpawnTimer.wait_time = SPAWN_TIMER_SECS
    
    # On level load, register to the global spawner
    add_to_group(Level.LEVEL_SPAWNER_GROUP)

func activate() -> void:
    SpawnTimer.start()

func deactivate() -> void:
    SpawnTimer.stop()

func spawn(mob: Mob):
    var target: mobs_parent = get_tree().get_first_node_in_group(
        GameState.MOBS_GROUP
    )
    var pathing_helper: MobPather = MobPather.new()

    pathing_helper.add_child(mob)
    mob.mob_killed.connect(pathing_helper._on_mob_despawn)
    mob.mob_killed.connect(GameState._on_mob_killed)
    mob.mob_despawned.connect(pathing_helper._on_mob_despawn)
    mob.mob_despawned.connect(GameState._on_mob_despawn)
    target.get_random_mob_path().add_child(pathing_helper)

    mob.global_position = (
        global_position + Vector2(randf_range(
            -WIGGLE_ROOM_PERCENT * global_position.x,
            WIGGLE_ROOM_PERCENT * global_position.x,
        ), randf_range(
            -WIGGLE_ROOM_PERCENT * global_position.y,
            WIGGLE_ROOM_PERCENT * global_position.y,
        ))
    )

func _on_spawn_timer_timeout() -> void:
    emit_signal(spawn_mob.get_name())
