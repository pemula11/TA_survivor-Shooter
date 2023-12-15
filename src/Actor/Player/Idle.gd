extends State

var time_to_patrol : float = 2.0

func enter() -> void:
	super()
	time_to_patrol = randf_range(0.5, 2.5)
	parent.set_state(get_state_name())
	
func physics_update(delta):
	if parent is Enemy:
		time_to_patrol -= delta
		if check_has_target() == false and time_to_patrol <= 0.0:
				print("pindah")
				Transitioned.emit(self,"patrol")
				return
				
	if get_movement_input() != Vector2.ZERO:
		
		if parent is Enemy:
			
			if  check_has_target() == true and !move_component.distance_from_origin():
				Transitioned.emit(self,"chase")
				return
	
		Transitioned.emit(self,"move")
	
