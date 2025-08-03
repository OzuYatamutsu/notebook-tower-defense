class_name SlowTower
extends Tower

const NUM_PROJECTILES_TO_FIRE: int = 10

func _init() -> void:
    VALUE = 500
    Description = (
        "COST: {0} MONEY\n".format([VALUE]) +
        "\n" +
        "Tower which shoots snowflakes at nearby targets, slowing them.\n" +
        "\n" +
        "MINISCULE DAMAGE\n" +
        "MEDIUM RATE OF FIRE\n" +
        "MEDIUM RANGE"
    )
    UpgradesTo = [
        "res://towers/SlowthrowerTower.tscn",
        "res://towers/SlowflakeTower.tscn"
    ]
    IsUpgraded = false
    super._init()

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/Slow.tscn"),
        1000.00,  # Range
        3.5  # Rate of fire
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
