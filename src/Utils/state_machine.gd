extends Node
class_name State_Machine



var states : Dictionary = {}
var current_state : Base_state
@export var initial_state : Base_state

func _ready():
	pass

# Called when the node enters the scene tree for the first time.
func process(delta):
	if current_state:
		current_state.update(delta)

func  physics_process(delta):
	
	if current_state:
		current_state.physics_update(delta)


func unhandled_input(event: InputEvent):
	if current_state:
		current_state.process_input(event)


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
