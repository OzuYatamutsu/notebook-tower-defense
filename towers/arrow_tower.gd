class_name ArrowTower
extends StaticBody2D

const PROJECTILE_REF: PackedScene = preload("res://projectiles/Arrow.tscn")

@export var CURRENT_TARGET: Basic
@export var RATE_OF_FIRE_SECS = 1.0

@onready var ShootTimer: Timer = $Turret/ShootTimer
@onready var ProjectileRoot: Node2D = get_tree().get_first_node_in_group("projectiles")

func _ready() -> void:
    assert(
        PROJECTILE_REF != null,
        "Towers need a projectile assigned!"
    )
    assert(
        get_tree().has_group("projectiles"),
        "Towers need a projectile base node in the scene " +
        "tree to spawn projectiles!"
    )
    ShootTimer.wait_time = RATE_OF_FIRE_SECS
    ShootTimer.start()

func _process(delta: float) -> void:
    pass

func _on_targeting_radius_entered(body: Basic) -> void:
    if CURRENT_TARGET == null:
        print(str(self) + ": Got a target, " + str(body))
        CURRENT_TARGET = body

func _on_targeting_radius_exited(body: Node2D) -> void:
    print(str(self) + ": Lost my target, " + str(body))
    CURRENT_TARGET = null

func _on_shoot_timer_timeout() -> void:
    if CURRENT_TARGET == null:
        return

    var new_projectile: Projectile = PROJECTILE_REF.instantiate()
    ProjectileRoot.add_child(new_projectile)
    new_projectile.init(CURRENT_TARGET.global_position)

    print(str(self) + ": Shooting an arrow, " + str(new_projectile))
