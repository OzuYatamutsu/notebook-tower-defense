class_name Ui
extends CanvasLayer

@onready var MusicToggleButton: Button = $TopBar/MusicToggleButton
@onready var SfxToggleButton: Button = $TopBar/SfxToggleButton
@onready var InfoPanel: TowerInfoAndBuyPanel = $TowerInfoAndBuyPanel
var _isMapSelectScreen: bool = false

func _ready() -> void:
    _isMapSelectScreen = get_tree().current_scene.name.contains(
        "MapSelect"
    )
    
    if _isMapSelectScreen:
        InfoPanel.visible = false

func _on_music_toggle_button_pressed() -> void:
    GameState.toggle_bgm()
    if GameState.BGM_ENABLED:
        MusicToggleButton.text = "Music: ON"
    else:
        MusicToggleButton.text = "Music: OFF"

func _on_sfx_toggle_button_pressed() -> void:
    GameState.toggle_sfx()
    if GameState.SFX_ENABLED:
        SfxToggleButton.text = "SFX: ON"
    else:
        SfxToggleButton.text = "SFX: OFF"
