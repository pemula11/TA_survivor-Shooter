extends State


func enter() -> void:
	
	super()
	
	
	
func physics_update(delta):
	
	var movement_input = get_movement_input()
	#sprite.flip_h = parent.velocity.x < 0
	
	var move =( movement_input + parent.knockback )* SPEED 

	parent.knockback = lerp(parent.knockback, Vector2.ZERO, 0.2)
	parent.velocity = move
	parent.move_and_slide()

	if get_movement_input() == Vector2.ZERO:
			
			Transitioned.emit(self,"idle")



