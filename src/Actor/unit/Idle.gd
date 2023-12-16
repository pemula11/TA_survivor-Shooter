extends State

var time_to_patrol : float = 2.0

func enter() -> void:
	super()
	time_to_patrol = randf_range(0.5, 2.5)
	parent.set_state(get_state_name())
	
	
func physics_update(delta):
	
	time_to_patrol -= delta
	if target_manager.is_detect_player() == false and time_to_patrol <= 0.0:
		Transitioned.emit(self,"patrol")
		return

	if get_movement_input() != Vector2.ZERO:
		if  target_manager.is_detect_player() == true and !move_component.distance_from_origin():
			Transitioned.emit(self,"chase")
			return
	
	
	
	
	parent.velocity = parent.knockback * SPEED 
	parent.move_and_slide()
	parent.knockback = lerp(parent.knockback, Vector2.ZERO, 0.2)
