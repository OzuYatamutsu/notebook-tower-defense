class_name mobs_parent
extends Node2D

var MOB_PATHS: Array[Node]

func _ready() -> void:
    MOB_PATHS = get_children()

    assert(MOB_PATHS.size() > 0, "Mobs must have a series of Path2Ds to follow under mobs node!")
    for node in MOB_PATHS:
        assert(node is Path2D, "All children of mobs_parent should be Path2D!")
    randomize()

func get_random_mob_path() -> Path2D:
    return MOB_PATHS[randi() % MOB_PATHS.size()]
