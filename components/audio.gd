class_name Audio
extends Control

@onready var UiSfx: AudioStreamPlayer = $ui_sfx
@onready var MobSfx: AudioStreamPlayer = $mob_sfx
@onready var BgmChannel1: AudioStreamPlayer = $bgm_channel_1
@onready var BgmChannel2: AudioStreamPlayer = $bgm_channel_2

const SFX_UI_CLICK: AudioStreamWAV = preload("res://sfx/ui_click.wav")
const SFX_PROJECTILE_FIRE_DEFAULT: AudioStreamWAV = preload("res://sfx/ui_projectile_fire_default.wav")
const SFX_TOWER_PLACE: AudioStreamWAV = preload("res://sfx/ui_tower_place.wav")
const SFX_DEFAULT_DEATH: AudioStreamWAV = preload("res://sfx/ui_default_mob_killed.wav")
const SFX_BIGBOSS_DEATH: AudioStreamWAV = preload("res://sfx/mob_bigboss_death.wav")
const SFX_FATONE_DEATH: AudioStreamWAV = preload("res://sfx/mob_fatone_death.wav")

const BGM_FADE_TIME_SECS: float = 0.5
const BGM_INTRO_LOOP: AudioStreamMP3 = preload("res://bgm/bgm_intro_loop.mp3")
const BGM_WAVES_INITIAL: AudioStreamMP3 = preload("res://bgm/bgm_waves_initial.mp3")

var _should_play_sfx: bool = true
var _should_play_bgm: bool = true

# Plays BGM immediately.
func play_bgm(stream: AudioStream) -> void:
    if !_should_play_bgm:
        return

    if !BgmChannel1.playing:
        BgmChannel1.stream = stream
        BgmChannel1.stream.loop = true
        BgmChannel2.stop()
        BgmChannel1.play()
    else:
        BgmChannel2.stream = stream
        BgmChannel2.stream.loop = true
        BgmChannel1.stop()
        BgmChannel2.play()

func crossfade() -> void:
    # TODO NOT IMPLEMENTED
    var tween = create_tween()
    tween.tween_property(BgmChannel1, "volume_db", -80, BGM_FADE_TIME_SECS)
    tween.tween_property(BgmChannel2, "volume_db", 0, BGM_FADE_TIME_SECS)

func enable_bgm() -> void:
    print("audio: enabling bgm!")
    _should_play_bgm = true
    # TODO: which audio track to play?

func disable_bgm() -> void:
    print("audio: disabling bgm!")
    _should_play_bgm = false
    # TODO: which audio track to play?

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
