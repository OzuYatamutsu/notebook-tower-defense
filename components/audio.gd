class_name Audio
extends Control

@onready var UiSfx: AudioStreamPlayer = $ui_sfx
@onready var MobSfx: AudioStreamPlayer = $mob_sfx
@onready var Bgm: AudioStreamPlayer = $bgm

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
