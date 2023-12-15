extends State_Machine



func init(parent, shot_position, muzzle):
	for child in get_children():
		
		if child is Base_state:
			
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
			child.weapon = parent
			#child.sprite = sprite
			child.shot_position = shot_position
			
		
	if initial_state:
		initial_state.enter()
		current_state = initial_state
		
func  _ready():
	pass
