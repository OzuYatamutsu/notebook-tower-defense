class_name TowerUpgradeItem
extends Control

const CLEAR_DIGIT = 10

var THEME_POSITIVE_EFFECT: Theme = load("res://components/UpgradeItemEffectPositive.tres")
var THEME_NEGATIVE_EFFECT: Theme = load("res://components/UpgradeItemEffectNegative.tres")

@export var Cost: int
@export var TowerPath: String

@onready var TowerSprite: Sprite2D = $TowerSprite
@onready var UpgradeEffects: BoxContainer = $UpgradeEffects
@onready var DisabledNoMoneySprite: ColorRect = $TowerSprite/DisabledNoMoney
@onready var TowerSpriteButton: Button = $TowerSprite/Button

@onready var digit1 = $NumericLabel/digit1
@onready var digit2 = $NumericLabel/digit2
@onready var digit3 = $NumericLabel/digit3
@onready var digit4 = $NumericLabel/digit4

func _process(_delta: float) -> void:
    if GameState.PLAYER_MONEY_REMAINING < Cost:
        DisabledNoMoneySprite.visible = true
        TowerSpriteButton.disabled = true
        TowerSpriteButton.mouse_default_cursor_shape = Control.CURSOR_ARROW
    else:
        DisabledNoMoneySprite.visible = false
        TowerSpriteButton.disabled = false
        TowerSpriteButton.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

func setup(towerPath: String) -> void:
    var tower: Tower = load(towerPath).instantiate()

    Cost = tower.VALUE
    TowerPath = towerPath

    get_node("TowerSprite").texture = tower.get_node("Sprite").texture
    clear_upgrade_effects()
    for upgrade_effect in tower.UpgradeEffects:
        add_upgrade_effect(upgrade_effect)

    tower.queue_free()
    set_anchors_preset(Control.PRESET_FULL_RECT)
    _set_numeric_label()

func clear_upgrade_effects() -> void:
    for _upgradeEffect in UpgradeEffects.get_children():
        UpgradeEffects.remove_child(_upgradeEffect)

func add_upgrade_effect(effect: String) -> void:
    var upgrade_effect_label = Label.new()
    upgrade_effect_label.text = effect
    if effect[0] == "+":
        upgrade_effect_label.theme = THEME_POSITIVE_EFFECT
    elif effect[0] == "-":
        upgrade_effect_label.theme = THEME_NEGATIVE_EFFECT
    UpgradeEffects.add_child(upgrade_effect_label)

func _set_numeric_label() -> void:
    digit1.frame = CLEAR_DIGIT
    digit2.frame = CLEAR_DIGIT
    digit3.frame = CLEAR_DIGIT
    digit4.frame = CLEAR_DIGIT
    
    if Cost <= 0:
        Cost = 0
    elif Cost >= 9999:
        Cost = 9999

    var str_value = str(Cost)
    var length = str_value.length()

    # Alignment
    var start_index = 4 - length

    for i in range(length):
        var digit = int(str_value[i])
        match start_index + i:
            0: digit1.frame = digit
            1: digit2.frame = digit
            2: digit3.frame = digit
            3: digit4.frame = digit

func _on_button_pressed() -> void:
    GameState.TOWER_UPGRADE_PANEL.disable()
    if GameState.PLAYER_MONEY_REMAINING < Cost:
        print("Not upgrading tower; not enough money")
        return
    
    # Replace tower with the new one
    var old_tower = GameState.TOWER_UPGRADE_PANEL.SelectedTower
    var old_position: Vector2 = old_tower.global_position
    old_tower.queue_free()

    var new_tower: Tower = load(TowerPath).instantiate()

    get_tree().get_first_node_in_group(
        GameState.TOWERS_GROUP
    ).add_child(
        new_tower
    )

    new_tower.global_position = old_position
    GameState.deduct_money(Cost)
