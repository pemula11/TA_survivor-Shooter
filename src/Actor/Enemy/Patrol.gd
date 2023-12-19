extends State

signal  make_random_target

func enter() -> void:
	
	super()
	move_component.generate_random_target()
	parent.set_state(get_state_name())
	
func physics_update(delta):
	
	var movement_input = get_movement_input()
	if move_component.check_navigation_finished():
			Transitioned.emit(self,"idle")
	if  check_has_target() == true and !move_component.distance_from_origin():
		Transitioned.emit(self,"chase")
	move_component.move_and_slide_navigation((movement_input+parent.knockback )* SPEED)
	parent.knockback = lerp(parent.knockback, Vector2.ZERO, 0.2)

