class_name Tower
extends Area2D

const MAX_CIRCLE_SELECTION_ATTEMPTS = 50

@export var PROJECTILE_REF: PackedScene
@export var CURRENT_TARGET: Mob
@export var TARGETING_RADIUS_PX: float
@export var RATE_OF_FIRE_SECS: float
@export var IS_ACTIVE = false
@export var VALUE: int

@onready var ShootTimer: Timer
@onready var TargetingRadius: Area2D
@onready var ProjectileRoot: Node2D = get_tree().get_first_node_in_group(GameState.PROJECTILES_GROUP)
@onready var Sprite: Sprite2D = $Sprite

var TargetingQueue: Array[Mob]
var ShouldFireImmediately: bool = true
var IsUpgraded: bool
var UpgradeEffects: Array[String]
var UpgradesTo: Array[String]  # Array of paths

func _init():
    # Every time the timer expires, spawn and fire
    # a projectile (create the timer here and set it
    # up on ready_tower()
    ShootTimer = Timer.new()
    ShootTimer.name = "ShootTimer"
    
    # Create the targeting radius
    var radius_shape = CollisionShape2D.new()
    radius_shape.shape = CircleShape2D.new()
    TargetingRadius = Area2D.new()
    TargetingRadius.name = "TargetingRadius"
    TargetingRadius.collision_layer = 0x0  # no collision layer
    TargetingRadius.collision_mask = 0x4  # target mobs
    TargetingRadius.add_child(radius_shape)

    # Add the components we created
    add_child(ShootTimer)
    add_child(TargetingRadius)

    # Hook up signals
    ShootTimer.timeout.connect(_on_shoot_timer_timeout)
    TargetingRadius.area_entered.connect(_on_targeting_radius_entered)
    TargetingRadius.area_exited.connect(_on_targeting_radius_exited)

func ready_tower(projectile: PackedScene, targeting_radius_px: float, rate_of_fire_secs: float) -> void:
    # Call this when we're placing the tower
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
    if !IS_ACTIVE:
        return
    if CURRENT_TARGET != null:
        TargetingQueue.append(body)
        return

    print(str(self) + ": Switching targets: " + str(body))
    CURRENT_TARGET = body
    
    # When we spawn a tower, we want it to fire
    # as soon as possible, but then reset the timer. 
    if ShouldFireImmediately:
        ShouldFireImmediately = false
        fire.call_deferred()
        enable()

func _on_targeting_radius_exited(body: Mob) -> void:
    if !IS_ACTIVE:
        return
    if body != CURRENT_TARGET:
        TargetingQueue.erase(body)
        return

    print(str(self) + ": Target out of range: " + str(body))
    
    if !TargetingQueue.is_empty():
        CURRENT_TARGET = TargetingQueue.pop_front()
        print(str(self) + ": Switching targets to: " + str(CURRENT_TARGET))
    else:
        CURRENT_TARGET = null

func _on_shoot_timer_timeout() -> void:
    if !IS_ACTIVE:
        return
    if CURRENT_TARGET == null:
        ShouldFireImmediately = true
        return

    fire()

func _get_random_non_wall_point_within_targeting_radius() -> Vector2:
    var space_state = get_world_2d().direct_space_state

    for i in MAX_CIRCLE_SELECTION_ATTEMPTS:
        # Attempt to generate a random point by generating
        # a random angle from our position and shooting 
        # a ray of random length
        var angle = randf() * TAU
        var distance = randf() * TARGETING_RADIUS_PX * scale.x
        var attempted_point: Vector2 = (
            Vector2(cos(angle), sin(angle)) * distance
        ) + global_position
        
        # Verify that the point isn't in a wall
        var query = PhysicsShapeQueryParameters2D.new()
        query.shape = CircleShape2D.new()
        query.shape.radius = 1.0
        query.transform = Transform2D.IDENTITY
        query.transform.origin = attempted_point
        query.collision_mask = 0x2  # walls
        query.collide_with_areas = true
        query.collide_with_bodies = false
        if space_state.intersect_shape(query, 1).is_empty():
            return attempted_point
        print("try again")
    return Vector2.ZERO

func fire() -> void:
    # Spawn a new projectile
    var new_projectile: Projectile = PROJECTILE_REF.instantiate()
    ProjectileRoot.add_child(new_projectile)
    new_projectile.global_position = global_position

    # ...and fire it at our target!
    new_projectile.fire_at(CURRENT_TARGET)
    print(str(self) + ": Shooting at: " + str(CURRENT_TARGET))
