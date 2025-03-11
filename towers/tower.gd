class_name Tower
extends StaticBody2D

@export var PROJECTILE_REF: PackedScene
@export var CURRENT_TARGET: Basic
@export var TARGETING_RADIUS_PX: float
@export var RATE_OF_FIRE_SECS: float
@export var IS_ACTIVE = false

@onready var ShootTimer: Timer
@onready var TargetingRadius: Area2D
@onready var ProjectileRoot: Node2D = get_tree().get_first_node_in_group("projectiles")

func _init():
    # Every time the timer expires, spawn and fire
    # a projectile (create the timer here and set it
    # up on ready_tower()
    ShootTimer = Timer.new()
    ShootTimer.name = "ShootTimer"
    ShootTimer.connect("timeout", _on_shoot_timer_timeout)
    
    # Create the targeting radius
    var radius_shape = CollisionShape2D.new()
    radius_shape.shape = CircleShape2D.new()
    TargetingRadius = Area2D.new()
    TargetingRadius.name = "TargetingRadius"
    TargetingRadius.collision_mask = 0x2
    TargetingRadius.add_child(radius_shape)
    TargetingRadius.connect("body_entered", _on_targeting_radius_entered)
    TargetingRadius.connect("body_exited", _on_targeting_radius_exited)

    add_child(ShootTimer)
    add_child(TargetingRadius)

func ready_tower(projectile: PackedScene, targeting_radius_px: float, rate_of_fire_secs: float) -> void:
    PROJECTILE_REF = projectile
    TARGETING_RADIUS_PX = targeting_radius_px
    RATE_OF_FIRE_SECS = rate_of_fire_secs
    TargetingRadius.get_children()[0].shape.radius = TARGETING_RADIUS_PX

func enable():
    # Start firing!
    IS_ACTIVE = true
    ShootTimer.wait_time = RATE_OF_FIRE_SECS
    ShootTimer.start()

func disable():
    # Stop firing...
    IS_ACTIVE = false
    ShootTimer.stop()
    ShootTimer.wait_time = RATE_OF_FIRE_SECS

func _on_targeting_radius_entered(body: Mob) -> void:
    if !IS_ACTIVE or CURRENT_TARGET != null:
        return

    print(str(self) + ": Got a target, " + str(body))
    CURRENT_TARGET = body

func _on_targeting_radius_exited(body: Mob) -> void:
    if !IS_ACTIVE:
        return

    print(str(self) + ": Lost my target, " + str(body))
    CURRENT_TARGET = null

func _on_shoot_timer_timeout() -> void:
    if !IS_ACTIVE or CURRENT_TARGET == null:
        return

    # Spawn a new projectile
    var new_projectile: Projectile = PROJECTILE_REF.instantiate()
    get_tree().get_first_node_in_group("projectiles").add_child(new_projectile)

    # ...and fire it at our target!
    new_projectile.fire_at(CURRENT_TARGET)
    print(str(self) + ": Shooting at: " + str(new_projectile))
