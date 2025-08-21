class_name Audio
extends Control

@onready var UiSfx: AudioStreamPlayer = $ui_sfx
@onready var MobSfx: AudioStreamPlayer = $mob_sfx
@onready var Bgm: AudioStreamPlayer = $bgm

const SFX_UI_CLICK: AudioStreamWAV = preload("res://sfx/ui_click.wav")
const SFX_PROJECTILE_FIRE_DEFAULT: AudioStreamWAV = preload("res://sfx/ui_projectile_fire_default.wav")
const SFX_TOWER_PLACE: AudioStreamWAV = preload("res://sfx/ui_tower_place.wav")
const SFX_DEFAULT_DEATH: AudioStreamWAV = preload("res://sfx/ui_default_mob_killed.wav")
const SFX_BIGBOSS_DEATH: AudioStreamWAV = preload("res://sfx/mob_bigboss_death.wav")
const SFX_FATONE_DEATH: AudioStreamWAV = preload("res://sfx/mob_fatone_death.wav")

const BGM_FADE_TIME_SECS: float = 0.5

const BGM_LOOP_0: AudioStreamMP3 = preload("res://bgm/1_loop_0.mp3")
const BGM_LOOP_1: AudioStreamMP3 = preload("res://bgm/2_loop_1.mp3")
const BGM_LOOP_2: AudioStreamMP3 = preload("res://bgm/3_loop_2.mp3")
const BGM_LOOP_3: AudioStreamMP3 = preload("res://bgm/4_loop_3.mp3")
const BGM_LOOP_4: AudioStreamMP3 = preload("res://bgm/5_loop_4.mp3")
const BGM_LOOP_5: AudioStreamMP3 = preload("res://bgm/7_loop_5.mp3")
const BGM_LOOP_6: AudioStreamMP3 = preload("res://bgm/9_loop_6.mp3")
const BGM_LOOP_7: AudioStreamMP3 = preload("res://bgm/10_loop_7.mp3")
const BGM_X_LOOP_4_TO_LOOP_5: AudioStreamMP3 = preload("res://bgm/6_x_l4_to_l5.mp3")
const BGM_X_LOOP_5_TO_LOOP_6: AudioStreamMP3 = preload("res://bgm/8_x_l5_to_l6.mp3")

var _should_play_sfx: bool = true
var _should_play_bgm: bool = true

# Plays BGM immediately.
func play_bgm(stream: AudioStream) -> void:
    if !_should_play_bgm:
        return

    Bgm.stream = stream
    Bgm.play()

func enable_bgm() -> void:
    print("audio: enabling bgm!")
    _should_play_bgm = true
    Bgm.play()

func disable_bgm() -> void:
    print("audio: disabling bgm!")
    _should_play_bgm = false
    Bgm.stop()

func enable_sfx() -> void:
    print("audio: enabling sfx!")
    _should_play_sfx = true

func disable_sfx() -> void:
    print("audio: disabling sfx!")
    _should_play_sfx = false

func play_mob_sfx(stream: AudioStream) -> void:
    if !_should_play_sfx:
        return
    MobSfx.stream = stream
    MobSfx.play()

func play_ui_sfx(stream: AudioStream) -> void:
    if !_should_play_sfx:
        return
    UiSfx.stream = stream
    UiSfx.play()
