
extends Node2D
class_name  HealthComponet

signal  health_changed()
signal  health_deplend()

@export var health : int
@export var max_health : int


func damage(amount, effect = null):
	health -= amount
	health = max(0, health)
	emit_signal("health_changed", health)
	if health == 0:
		emit_signal("health_deplend")
	
func heal(amount, effect = null):
	health -= amount
	health = min( health, max_health)
