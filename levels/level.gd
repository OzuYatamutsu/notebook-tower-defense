class_name Level
extends Node

const LEVEL_SPAWNER_GROUP = "level_spawner"
const WAVE_METER_GROUP = "wave_meter"

const WAVE_TIMER_SECS = 15.0

# How many mobs should the spawner spawn at once?
const MOBS_TO_SPAWN_AT_ONCE: int = 2

# Formula which determines how fast a Mob hp's grows over
# progressive waves.
var WAVE_HEALTH_MULTIPLIER: Callable = func(wave_num):
    return 1 + (wave_num * 0.05)

var WAVE_CONTENTS: Array[Dictionary]
var WAVES: Array[Wave] = []
var CURRENT_WAVE: Wave
var CURRENT_WAVE_TIMER: Timer
var WAVE_METER: WaveMeter
var SPAWNER: LevelSpawn
var WAITING_FOR_LAST_MOB_FLAG: bool = false

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

    for wave_contents in WAVE_CONTENTS:
        WAVES.append(Wave.new(wave_contents))
    CURRENT_WAVE = WAVES.pop_front()
    GameState._on_level_load()

func start_wave() -> void:
    CURRENT_WAVE_NUM += 1
    WAVE_METER.update_value_text()
    CURRENT_WAVE_TIMER.start()
    WAVE_METER.WaveTimerUI.set_max_time(CURRENT_WAVE_TIMER.wait_time)
    WAVE_METER.WaveTimerUI.enable()
    CURRENT_WAVE.start()
    SPAWNER.activate()
    
    GameState.NEXT_WAVE_METER.reset_next_mob_types()

    if !WAVES.is_empty():
        GameState.NEXT_WAVE_METER.set_next_mob_types(WAVES[0])

func end_wave() -> void:
    CURRENT_WAVE_TIMER.stop()
    WAVE_METER.WaveTimerUI.disable()
    CURRENT_WAVE.end()
    SPAWNER.deactivate()

func next_wave() -> void:
    end_wave()

    if !WAVES.is_empty():
        GameState.add_money(
            CURRENT_WAVE.WAVE_END_MONEY_BONUS
        )
        print("Starting next wave!")
        CURRENT_WAVE = WAVES.pop_front()
    else:
        print("No more waves!")
        WAITING_FOR_LAST_MOB_FLAG = true
        return
    start_wave()

func no_waves_remaining() -> bool:
    return WAVES.is_empty()

func _on_spawn_signal() -> void:
    for i in range(MOBS_TO_SPAWN_AT_ONCE):
        if CURRENT_WAVE.is_empty():
            return

        var mob_to_spawn: Mob = CURRENT_WAVE.pop()
        mob_to_spawn.MAX_HP *= WAVE_HEALTH_MULTIPLIER.call(CURRENT_WAVE_NUM)

        SPAWNER.spawn(mob_to_spawn)
        print("Spawning: " + str(mob_to_spawn))
