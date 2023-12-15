extends State

func enter() -> void:
	
	super()
	move_component.generate_random_target()
	parent.set_state(get_state_name())
	
func physics_update(delta):
	move_component.back_to_origin()
	var movement_input = get_movement_input()
	if move_component.check_navigation_finished():
			Transitioned.emit(self,"idle")
	move_component.move_and_slide_navigation(movement_input * SPEED)

