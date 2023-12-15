extends State


var time_to_attack : float = 0.5
var direction
var target
var current_point

func enter() -> void:
	super()
	#time_to_attack = 0.5
	#parent.set_state(get_state_name())
	#direction = (move_component.player.global_position - parent.global_position).normalized()
	#target = move_component.player.global_position
	#current_point = parent.global_position
	
func physics_update(delta):
	
	#time_to_attack -= delta
	#if time_to_attack <= 0.0:
		#
		#parent.velocity = direction * SPEED * 1.5
		#parent.move_and_slide()
		#if parent.global_position.distance_to(target) < 8:
			#parent.move_toward(current_point)
