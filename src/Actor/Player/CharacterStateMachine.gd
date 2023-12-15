extends Node
class_name Character_State_Machine

var states : Dictionary = {}
var current_state : State
@export var initial_state : State


# Called when the node enters the scene tree for the first time.
func init(parent, animation, movement, sprite):
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
			child.parent = parent
			child.sprite = sprite
			child.animations = animation
			child.move_component = movement
			child.SPEED = parent.SPEED
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta):
	if current_state:
		current_state.update(delta)

func  physics_process(delta):
	
	if current_state:
		current_state.physics_update(delta)


func _unhandled_input(event: InputEvent):
	pass


func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
		
	if current_state:
		current_state.exit()
	
	current_state = new_state
	
	current_state.enter()
	
	
	
