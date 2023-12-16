extends Node
class_name TargetManager

var parent : Actor
@export var weapon : Weapon
var LineOfSight : Area2D
@export var target_Detector : RayCast2D
var player = null

signal on_detect_player

func  init(owners,locker, weapon):
	parent = owners
	LineOfSight = locker
	weapon = weapon

func  _ready():
	LineOfSight.body_entered.connect(on_detect_target)
	LineOfSight.body_exited.connect(on_lost_target)

func is_target_locked():
	if target_Detector.is_colliding():
		
		var collider = target_Detector.get_collider()
		if collider and collider.is_in_group("player"):
			
			return true
	return false



func on_detect_target(body):
	player = body

func on_lost_target(body):
	player = null

func is_detect_player():
	if player != null:
		return true
	return false
