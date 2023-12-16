extends Node


var nav_agent
var player
var parent
@export var los : RayCast2D
var player_spotted : bool
@onready var timer = $Timer
var max_patrol
var origin_position


func init(nav, target, parents, patrol, origin):
	nav_agent = nav
	player = target
	parent = parents
	max_patrol = patrol
	origin_position = origin

func generate_random_target():
	if parent.global_position.distance_to(origin_position) > max_patrol:
		nav_agent.target_position = origin_position
		return
	var new_target = parent.global_position +Vector2(randf_range(-200,200), randf_range(-200,200))
	nav_agent.target_position =  new_target
	
func get_input():
	direction_animation()
	return parent.to_local(nav_agent.get_next_path_position()).normalized()



func make_path():
	if distance_from_origin() == true:
		nav_agent.target_position = origin_position
		return
	if check_collider_sight() == true:
		nav_agent.target_position = player.global_position
	
	


func _on_timer_timeout():
	
	make_path()

func direction_animation():
	var pos = (nav_agent.get_next_path_position() - parent.global_position).normalized()
	if pos.x < 0:
		parent.sprite.flip_h = true
	elif pos.x > 0:
		parent.sprite.flip_h = false

func check_collider_sight():
	if los.is_colliding():
		
		var collider = los.get_collider()
		if collider and collider.is_in_group("player"):
			
			return true
	return false

func check_navigation_finished():
	return nav_agent.is_navigation_finished()

func distance_from_origin():
	if parent.global_position.distance_to(origin_position) > max_patrol:
		return true
	return false

func go_to_origin():
	return parent.global_position.distance_to(origin_position)

func move_and_slide_navigation(velocity):
	nav_agent.set_velocity(velocity)

func back_to_origin():
	nav_agent.target_position = origin_position

func set_idle_target():
	nav_agent.target_position = nav_agent.target_position

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	parent.velocity = safe_velocity
	parent.move_and_slide()
