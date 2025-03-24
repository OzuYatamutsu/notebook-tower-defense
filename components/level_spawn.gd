class_name LevelSpawn
extends Area2D

signal spawn_mob

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
    get_tree().get_first_node_in_group(
        GameState.MOBS_GROUP
    ).add_child(mob)
    mob.global_position = global_position

func _on_spawn_timer_timeout() -> void:
    emit_signal(spawn_mob.get_name())
