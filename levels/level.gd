class_name Level
extends Node

const LEVEL_SPAWNER_GROUP = "level_spawner"
const WAVE_METER_GROUP = "wave_meter"

const WAVE_TIMER_SECS = 15.0

var WAVE_CONTENTS: Array[Dictionary]
var WAVES: Array[Wave] = []
var CURRENT_WAVE: Wave
var CURRENT_WAVE_TIMER: Timer
var WAVE_METER: WaveMeter
var SPAWNER: LevelSpawn

@export var CURRENT_WAVE_NUM = 0

func _ready() -> void:
    GameState.CURRENT_LEVEL = self

    SPAWNER = get_tree().get_first_node_in_group(LEVEL_SPAWNER_GROUP)
    SPAWNER.spawn_mob.connect(_on_spawn_signal)

    WAVE_METER = get_tree().get_first_node_in_group(WAVE_METER_GROUP)
    WAVE_METER.set_max_value(len(WAVE_CONTENTS))

    CURRENT_WAVE_TIMER = Timer.new()
    CURRENT_WAVE_TIMER.wait_time = WAVE_TIMER_SECS
    CURRENT_WAVE_TIMER.timeout.connect(next_wave)
    add_child(CURRENT_WAVE_TIMER)

    GameState.PLAYER_LIVES_START = 5  # TODO
    GameState.PLAYER_MONEY_REMAINING = 200  # TODO

    for wave_contents in WAVE_CONTENTS:
        WAVES.append(Wave.new(wave_contents))
    CURRENT_WAVE = WAVES.pop_front()
    GameState._on_level_load()

func start_wave() -> void:
    CURRENT_WAVE_NUM += 1
    WAVE_METER.set_value(CURRENT_WAVE_NUM)
    CURRENT_WAVE_TIMER.start()
    CURRENT_WAVE.start()
    SPAWNER.activate()
    
    if !WAVES.is_empty():
        GameState.NEXT_WAVE_METER.set_next_mob_types(WAVES[0])

func end_wave() -> void:
    CURRENT_WAVE_TIMER.stop()
    CURRENT_WAVE.end()
    SPAWNER.deactivate()

func next_wave() -> void:
    end_wave()
    
    if !WAVES.is_empty():
        print("Starting next wave!")
        CURRENT_WAVE = WAVES.pop_front()
    else:
        print("No more waves!")
        return
    start_wave()

func _on_spawn_signal() -> void:
    if CURRENT_WAVE.is_empty():
        return

    var mob_to_spawn: Mob = CURRENT_WAVE.pop()

    print("Spawning: " + str(mob_to_spawn))
    SPAWNER.spawn(mob_to_spawn)
