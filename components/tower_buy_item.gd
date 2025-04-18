class_name TowerBuyItem
extends Control

const CLEAR_DIGIT = 10

@export var Cost: int
@export var TowerPath: String

@onready var TowerSprite: TextureRect = $TowerSprite

@onready var digit1 = $NumericLabel/digit1
@onready var digit2 = $NumericLabel/digit2
@onready var digit3 = $NumericLabel/digit3
@onready var digit4 = $NumericLabel/digit4

func _init(towerPath: String) -> void:
    TowerPath = towerPath

func _ready() -> void:
    var tower = load(TowerPath).instantiate()
    
    Cost = tower.VALUE
    TowerSprite.texture = tower.get_node("Sprite").texture
    _set_numeric_label()
    tower.queue_free()

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
    var start_index = 5 - length

    for i in range(length):
        var digit = int(str_value[i])
        match start_index + i:
            0: digit1.frame = digit
            1: digit2.frame = digit
            2: digit3.frame = digit
            3: digit4.frame = digit
