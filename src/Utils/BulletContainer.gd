extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.shoot_target.connect(on_shoot_target)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_shoot_target(bullet):
	add_child(bullet)
