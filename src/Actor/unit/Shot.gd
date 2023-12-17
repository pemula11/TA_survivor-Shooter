extends State

@export var bullet :PackedScene
@export var shot_position : Marker2D
@onready var timer = $Timer



func enter() -> void:
	
	super()
	parent.set_state(get_state_name())
	move_component.direction_animation()
	var bullet_instance = bullet.instantiate()
	
	var target = target_manager.get_target_location()
	bullet_instance.init(parent, target, parent.damage_bullet, shot_position.global_position, parent.BULLET_SPEED, 
								Vector2.ZERO, parent.distance_bullet)
	#bullet_container.add_child(bullet_instance)
	SignalManager.emit_signal("shoot_target", bullet_instance)
	timer.start()
	await timer.timeout
	Transitioned.emit(self,"idle")
	
func physics_update(delta):
	
	pass

