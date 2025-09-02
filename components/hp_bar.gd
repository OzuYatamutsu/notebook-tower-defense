class_name HpBar
extends Node2D

# fired when hp=0
signal no_hp

const HP_BAR_MAX_WIDTH = 400.0
const HP_BAR_MAX_HEIGHT = 65.0

@onready var HpBarSprite: Sprite2D = $HpBarFullSprite

var MAX_HP: float
var HP: float

func set_max_hp(max_hp: float) -> void:
    MAX_HP = max_hp
    HP = max_hp

func damage_by(amount: float) -> void:
    HP -= amount
    if HP <= 0:
        HP = 0
        update_health_bar()
        emit_signal("no_hp")
    else:
        update_health_bar()

func heal_by(amount: float) -> void:
    HP += amount
    if HP >= MAX_HP:
        HP = MAX_HP
    update_health_bar()

func set_to(amount: float) -> void:
    HP = amount
    if HP <= 0:
        HP = 0
        emit_signal("no_hp")
        update_health_bar()
    elif HP >= MAX_HP:
        HP = MAX_HP
    else:
        update_health_bar()

func update_health_bar() -> void:
    HpBarSprite.region_rect.size = Vector2(
        HP_BAR_MAX_WIDTH * (HP / MAX_HP),
        HP_BAR_MAX_HEIGHT
    )
