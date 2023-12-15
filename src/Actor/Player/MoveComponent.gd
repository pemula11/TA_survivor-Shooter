extends Node

@onready var parent = $".."
@onready var sprite = $"../AnimatedSprite2D"

func _physics_process(delta):
	direction_animation()

func get_input():
	return Input.get_vector("left", "right", "up", "down")

func direction_animation():
	var pos = (parent.get_global_mouse_position() - parent.global_position).normalized()
	if pos.x < 0:
		sprite.flip_h = true
	elif pos.x > 0:
		sprite.flip_h = false
