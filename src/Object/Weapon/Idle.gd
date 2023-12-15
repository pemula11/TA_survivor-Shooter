extends Base_state

var weapon : Weapon
var shot_position: Marker2D

func enter():
	super()
	weapon.set_label(state_name)

func _physics_process(delta):
	pass

func process_input(event: InputEvent):
	
	if event.get_action_strength("shot") == 1:
		
		Transitioned.emit(self, "firing")
