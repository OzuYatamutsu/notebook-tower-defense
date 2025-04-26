class_name Effect
extends Node

# Should be a function with one parameter of type Mob
var EffectFunc: Callable

func _init(effect: Callable) -> void:
    EffectFunc = effect

func apply(to: Mob) -> void:
    EffectFunc.call(to)
