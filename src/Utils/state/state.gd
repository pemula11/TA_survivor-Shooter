extends Base_state
class_name State


var animations: AnimationPlayer
var move_component 
var parent: CharacterBody2D
var sprite: AnimatedSprite2D


@export var animation_name :String

@export var SPEED : float = 80

# Called when the node enters the scene tree for the first time.

func enter():
	animations.play(animation_name)

func get_movement_input():
	
	return move_component.get_input()

func check_has_target():
	return move_component.check_collider_sight()
