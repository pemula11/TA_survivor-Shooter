extends Node
class_name TargetManager

var parent : Actor
@export var weapon : Weapon
var LineOfSight : Area2D
@export var attack_Detector : RayCast2D
var player = null
@export var target_detector : RayCast2D
var target_in_area = false
signal on_detect_player
@export var shot_position : Marker2D


func  init(owners,locker, max_target_seen, target,  weapon = null):
	parent = owners
	LineOfSight = locker
	weapon = weapon
	LineOfSight.body_entered.connect(on_detect_target)
	LineOfSight.body_exited.connect(on_lost_target)
	
	player = target
	
	
func _physics_process(delta):
	
	if target_in_area == true:
		target_detector.look_at(player.global_position)
		attack_Detector.look_at(player.global_position)

func is_target_locked():
	if target_detector.is_colliding():
		
		var collider = target_detector.get_collider()
		if collider and collider.is_in_group("player"):
			
			return true
	return false



func check_collider_sight():
	if attack_Detector.is_colliding():
		
		var collider = attack_Detector.get_collider()
		if collider and collider.is_in_group("player"):
			
			return true
	return false


func can_shoot_target():
	if attack_Detector.is_colliding():
		
		var collider = attack_Detector.get_collider()
		if collider and collider.is_in_group("player"):
			
			return true
	return false

func get_target_location() -> Vector2:
	return (player.global_position- shot_position.global_position).normalized()

func on_detect_target(body):
	print("Ok")
	target_in_area = true

func on_lost_target(body):
	target_in_area = false

func is_detect_player():
	if  target_in_area == true and is_target_locked() == true:
		return true
	return false
