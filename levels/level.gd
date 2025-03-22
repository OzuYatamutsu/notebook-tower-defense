class_name Level
extends Node

const LEVEL_SPAWNER_GROUP = "level_spawner"

var WAVE_CONTENTS: Array[Dictionary]
var WAVES: Array[Wave] = []
var CURRENT_WAVE: Wave
var SPAWNER: LevelSpawn

@export var CURRENT_WAVE_NUM = 0

func _ready() -> void:
    SPAWNER = get_tree().get_first_node_in_group(LEVEL_SPAWNER_GROUP)
    SPAWNER.connect(SPAWNER.spawn_mob.get_name(), _on_spawn_signal)

    GameState.PLAYER_LIVES_START = 5  # TODO
    for wave_contents in WAVE_CONTENTS:
        WAVES.append(Wave.new(wave_contents))
    GameState._on_level_load()

func _on_spawn_signal() -> void:
    if CURRENT_WAVE.is_empty():
        return
    var mob_to_spawn: Mob = CURRENT_WAVE.pop()

    print("Spawning: " + str(mob_to_spawn))
    SPAWNER.spawn(mob_to_spawn)
