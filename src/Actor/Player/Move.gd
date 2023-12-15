extends State


func enter() -> void:
	
	super()
	
	
	
func physics_update(delta):
	
	var movement_input = get_movement_input()
	#sprite.flip_h = parent.velocity.x < 0
	
	var move = movement_input * SPEED 
	#parent.velocity.x = move_toward(parent.velocity.x, SPEED * movement_input.x, 10)
	#parent.velocity.y = move_toward(parent.velocity.y, SPEED * movement_input.y, 10)
	parent.velocity = move
	parent.move_and_slide()

	if get_movement_input() == Vector2.ZERO:
			
			Transitioned.emit(self,"idle")



