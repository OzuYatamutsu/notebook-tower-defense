class_name MissileTower
extends Tower

func _init() -> void:
    VALUE = 1250
    Description = (
        "COST: {0} MONEY\n".format([VALUE]) +
        "\n" +
        "Tower which shoots a slow missile at the target. " +
        "The missile explodes, dealing damage to all monsters " +
        "nearby.\n" +
        "\n"
    )
    IsUpgraded = true
    UpgradeEffects = [
        "+DAMAGE",
        "+SPLASH DAMAGE",
        "-FIRE RATE",
        "-SPEED"
    ]
    for effect in UpgradeEffects:
        Description += effect + "\n"
    super._init()

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/Missile.tscn"),
        1000.00,  # Range
        1.5  # Rate of fire
    )

    enable()
