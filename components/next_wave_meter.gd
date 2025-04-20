class_name NextWaveMeter
extends Control

@onready var NextMobSpriteContainer = $NextMobSpriteContainer

func _ready() -> void:
    reset_next_mob_types()

func reset_next_mob_types() -> void:
    for child in NextMobSpriteContainer.get_children():
        NextMobSpriteContainer.remove_child(child)

func set_next_mob_types(for_wave: Wave) -> void:
    for mob_type in for_wave.CURRENT_WAVE_CONTENTS:
        var prototype_mob: Mob = load(mob_type).instantiate()
        var new_mob_sprite = TextureRect.new()

        new_mob_sprite.texture = prototype_mob.get_node("Sprite").texture
        NextMobSpriteContainer.add_child(new_mob_sprite)
        prototype_mob.queue_free()
