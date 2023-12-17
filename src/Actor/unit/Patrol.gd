extends State

signal  make_random_target

func enter() -> void:
	
	super()
	move_component.generate_random_target()
	parent.set_state(get_state_name())
	
func physics_update(delta):
	
	var movement_input = get_movement_input()
	if move_component.check_navigation_finished() == true:
			Transitioned.emit(self,"idle")
	if  target_manager.is_detect_player() == true and !move_component.distance_from_origin():
		Transitioned.emit(self,"chase")
	
	
	move_component.move_and_slide_navigation(movement_input * SPEED)

