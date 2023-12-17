extends State

func enter() -> void:
	
	super()
	move_component.generate_random_target()
	parent.set_state(get_state_name())
	move_component.back_to_origin()
	
func physics_update(delta):
	
	var movement_input = get_movement_input()
	if move_component.check_navigation_finished():
			Transitioned.emit(self,"idle")
	if target_manager.can_shoot_target() == true:
		Transitioned.emit(self,"shoot")
	move_component.move_and_slide_navigation(movement_input * SPEED)
	
