class_name NextWaveMeter
extends Control

const BGRECT_MIN_WIDTH_PIXELS = 540
const MOB_WIDTH_PIXELS = 500

@onready var NextMobSpriteContainer: HBoxContainer = $NextMobSpriteContainer

func _ready() -> void:
    reset_next_mob_types()

func reset_next_mob_types() -> void:
    for child in NextMobSpriteContainer.get_children():
        NextMobSpriteContainer.remove_child(child)

func set_next_mob_types(for_wave: Wave) -> void:
    var unique_mob_types: Array[String] = []

    for mob_type in for_wave.CURRENT_WAVE_CONTENTS:
        if mob_type in unique_mob_types:
            continue
        else:
            unique_mob_types.append(mob_type)

        var prototype_mob: Mob = load(mob_type).instantiate()
        var new_mob_sprite = TextureRect.new()

        new_mob_sprite.texture = prototype_mob.get_node("Sprite").texture
        NextMobSpriteContainer.add_child(new_mob_sprite)
        prototype_mob.queue_free()
