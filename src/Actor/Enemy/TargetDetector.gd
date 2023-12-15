extends Node
class_name TargetManager

@export var parent : Actor
@export var weapon : Weapon
var target_locker

signal on_detect_player

func  init(locker):
	target_locker = locker

func detect_player():
	
	if target_locker.is_colliding():
		
		var collider = target_locker.get_collider()
		if collider and collider.is_in_group("player"):
			
			return true
	return false

