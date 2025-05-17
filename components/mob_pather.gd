class_name MobPather
extends PathFollow2D

var child: Mob

func _init() -> void:
    rotates = false

func _ready() -> void:
    assert(get_child_count() == 1, "MobPather must have exactly 1 mob as a child!")
    child = get_child(0)

func _physics_process(delta: float) -> void:
    if (
        progress_ratio >= 100.0
        or progress_ratio + (child.SPEED * delta) >= 100.0
    ):
        progress_ratio = 100.0
        return
    progress_ratio += (child.SPEED * delta)

func _on_mob_despawn(_mob) -> void:
    queue_free()
