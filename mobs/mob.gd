class_name Mob
extends Area2D

signal mob_killed

@export var MAX_HP: float
@export var SPEED: float

@onready var HEALTH_BAR: HpBar = $HpBar

func _ready() -> void:
    HEALTH_BAR.set_max_hp(MAX_HP)
    area_entered.connect(_on_hit)
    mob_killed.connect(GameState.CURRENT_LEVEL._on_mob_killed)
    HEALTH_BAR.no_hp.connect(_on_death)

func _physics_process(delta: float) -> void:
    position += get_next_direction() * delta * SPEED

func get_next_direction() -> Vector2:
    # TODO for now just goes from left to right
    var direction = Vector2(1, 0)

    return direction

func _on_hit(projectile: Projectile) -> void:
    HEALTH_BAR.damage_by(projectile.DAMAGE)
    projectile.queue_free()

func _on_death():
    emit_signal(mob_killed.get_name())
    queue_free()
