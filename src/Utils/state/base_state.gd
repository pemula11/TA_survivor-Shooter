extends Node
class_name Base_state

signal  Transitioned
@export var _state_name :String


func process_input(event: InputEvent):
	pass

func enter():
	pass
	

func exit():
	pass

func update(delta):
	pass

func physics_update(delta):
	pass

func get_state_name():
	return _state_name
