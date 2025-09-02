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

func _reinit():
    add_to_group(GameState.MOB_MEMBERS_GROUP)
    if !mob_killed.has_connections():
        mob_killed.connect(GameState._on_mob_killed)
    if !mob_despawned.has_connections():
        mob_despawned.connect(GameState._on_mob_despawn)
    if !area_entered.has_connections():
        area_entered.connect(_on_hit)
    if HEALTH_BAR and !HEALTH_BAR.no_hp.is_connected(_on_death):
        HEALTH_BAR.no_hp.connect(_on_death)
    if HEALTH_BAR:
        HEALTH_BAR.set_max_hp(
            MAX_HP * (WAVE_MULTIPLIER ** WAVE_NUM)
        )
    if DESPAWN_TIMER and !DESPAWN_TIMER.timeout.is_connected(_on_despawn_timer_timeout):
        DESPAWN_TIMER.timeout.connect(_on_despawn_timer_timeout)
    visible = true

func _deinit():
    remove_from_group(GameState.MOB_MEMBERS_GROUP)
    
    if mob_killed.has_connections():
        mob_killed.disconnect(GameState._on_mob_killed)
    if mob_despawned.has_connections():
        mob_despawned.disconnect(GameState._on_mob_despawn)
    if area_entered.has_connections():
        area_entered.disconnect(_on_hit)
    if HEALTH_BAR:
        HEALTH_BAR.no_hp.disconnect(_on_death)
    if DESPAWN_TIMER:
        DESPAWN_TIMER.timeout.disconnect(_on_despawn_timer_timeout)
    visible = false

func _ready() -> void:
    HEALTH_BAR.no_hp.connect(_on_death)
    DESPAWN_TIMER.timeout.connect(_on_despawn_timer_timeout)

    HEALTH_BAR.set_max_hp(
        MAX_HP * (WAVE_MULTIPLIER ** WAVE_NUM)
    )
    SPEED *= (WAVE_MULTIPLIER ** WAVE_NUM)

func _on_hit(projectile: Projectile) -> void:
    HEALTH_BAR.damage_by(projectile.DAMAGE)
    while projectile.has_unapplied_effect():
        var effect = projectile.pop_next_effect()
        effect.apply(self)
    if projectile is not Laser:
        projectile.recycle()

func _on_death():
    GameState.AUDIO_CONTROL.play_mob_sfx(DEATH_SFX)
    GameState.add_money(VALUE)
    mob_killed.emit(self)
    recycle()

func delayed_despawn() -> void:
    DESPAWN_TIMER.start()

func _on_despawn_timer_timeout() -> void:
    mob_despawned.emit(self)
    recycle()

func _to_string() -> String:
    return "%s: hp=%s" % [name, str(HEALTH_BAR.HP)]

func recycle() -> void:
    Respawner.recycle_mob(self.get_script(), self)
