class_name SniperTower
extends Tower

func _init() -> void:
    VALUE = 1250
    Description = (
        "COST: {0} MONEY\n".format([VALUE]) +
        "\n" +
        "Tower which targets far away monsters with high accuracy.\n" +
        "\n"
    )
    IsUpgraded = true
    UpgradeEffects = [
        "+DAMAGE",
        "+SPEED",
        "+RANGE",
        "-FIRE RATE"
    ]
    for effect in UpgradeEffects:
        Description += effect + "\n"

    super._init()

func _ready() -> void:
    ready_tower(
        preload("res://projectiles/SniperBullet.tscn"),
        4000.0,
        3.50
    )

    enable()
