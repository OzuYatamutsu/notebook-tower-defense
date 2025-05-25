class_name SlowflakeTower
extends Tower

const NUM_PROJECTILES_TO_FIRE: int = 25

func _init() -> void:
    VALUE = 500
    IsUpgraded = true
    UpgradeEffects = [
        "++FIRE RATE",
        "+PROJECTILES",
        "+RANGE"
    ]
    super._init()

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/Slow.tscn"),
        2000.00,  # Range
        2.5  # Rate of fire
    )

    enable()

func fire() -> void:
    var segment_length: float = ((2 * PI) / NUM_PROJECTILES_TO_FIRE)

    for i in range(NUM_PROJECTILES_TO_FIRE):
        # Spawn a new projectile
        var new_projectile: Projectile = PROJECTILE_REF.instantiate()
        ProjectileRoot.add_child(new_projectile)
        new_projectile.global_position = global_position

        # ...and fire and forget in a circle
        new_projectile.fire(Vector2(
            cos(segment_length * i),
            sin(segment_length * i)
        ))
        print(str(self) + ": Shooting fof")
