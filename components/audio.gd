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

var _should_play_sfx: bool = true

func enable_bgm() -> void:
    print("audio: enabling bgm!")
    if !Bgm.playing:
        Bgm.play()

func disable_bgm() -> void:
    print("audio: disabling bgm!")
    if Bgm.playing:
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
