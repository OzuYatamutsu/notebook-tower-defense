class_name LevelSpawn
extends Area2D

signal spawn_mob

@export var SPAWN_TIMER_SECS: float = 0.5

@onready var SpawnTimer = $SpawnTimer

func _ready() -> void:
    SpawnTimer.timeout = SPAWN_TIMER_SECS
    
    # On level load, register to the global spawner
    add_to_group(GameState.LEVEL_SPAWNER_GROUP)

func spawn(mob: Mob):
    mob.global_position = global_position
    get_tree().get_first_node_in_group(GameState.MOBS_GROUP).add_child(mob)

func _on_spawn_timer_timeout() -> void:
    emit_signal(spawn_mob.get_name())
