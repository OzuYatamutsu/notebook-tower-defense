class_name SelectedTowerMeter
extends Control

@onready var SelectedTowerSprite = $Sprite

func update_sprite() -> void:
    SelectedTowerSprite.texture = \
        GameState.TOWER_PLACEMENT_SHADOW.TOWER_TO_PLACE\
            .get_node("Sprite").texture
