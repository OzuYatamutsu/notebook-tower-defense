class_name Mob
extends Area2D

signal mob_killed(Mob)
signal mob_despawned(Mob)

# How much should a mob type's starting health increase
# during subsequent waves?
# e.g. 1.03 = increase health by 3% (compounded)
const WAVE_MULTIPLIER: float = 1.05

# A mob cannot be slowed below this speed.
const MIN_SPEED: float = 0.010

@export var MAX_HP: int
@export var SPEED: float
@export var VALUE: int

@onready var HEALTH_BAR: HpBar = $HpBar
@onready var SPRITE: Sprite2D = $Sprite
@onready var DESPAWN_TIMER: Timer = $DespawnTimer
@onready var WAVE_NUM: int = GameState.CURRENT_LEVEL.CURRENT_WAVE_NUM

var DEATH_SFX = Audio.SFX_DEFAULT_DEATH

func _ready() -> void:
    HEALTH_BAR.set_max_hp(
        MAX_HP * (WAVE_MULTIPLIER ** WAVE_NUM)
    )
    SPEED *= (WAVE_MULTIPLIER ** WAVE_NUM)

    area_entered.connect(_on_hit)
    HEALTH_BAR.no_hp.connect(_on_death)
    DESPAWN_TIMER.timeout.connect(_on_despawn_timer_timeout)

func _on_hit(projectile: Projectile) -> void:
    HEALTH_BAR.damage_by(projectile.DAMAGE)
    print("DEBUG: damaged by " + str(projectile.name) + "/" + str(projectile.DAMAGE))
    while projectile.has_unapplied_effect():
        var effect = projectile.pop_next_effect()
        print("Applying effect! " + str(effect))
        effect.apply(self)
    if projectile is not Laser:
        projectile.queue_free()

func _on_death():
    GameState.AUDIO_CONTROL.play_mob_sfx(DEATH_SFX)
    remove_from_group(GameState.MOB_MEMBERS_GROUP)

    GameState.add_money(VALUE)
    mob_killed.emit(self)
    queue_free()

func delayed_despawn() -> void:
    DESPAWN_TIMER.start()

func _on_despawn_timer_timeout() -> void:
    remove_from_group(GameState.MOB_MEMBERS_GROUP)

    mob_despawned.emit(self)
    queue_free()

func _to_string() -> String:
    return "%s: hp=%s" % [name, str(HEALTH_BAR.HP)]
