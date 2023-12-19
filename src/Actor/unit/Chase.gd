extends State





func enter() -> void:
	
	super()
	move_component.timer.start()
	move_component.make_path()
	parent.set_state(get_state_name())
	#move_component.nav_agent.target_position = player.global_position
	
func physics_update(delta):
	
	#if  target_manager.is_detect_player() == false:
		#Transitioned.emit(self,"idle")
		#move_component.move_and_slide_navigation(Vector2.ZERO)
		#return
	if target_manager.can_shoot_target() == true:
		
		move_component.move_and_slide_navigation(Vector2.ZERO)
		Transitioned.emit(self,"shot")
		return
	if  move_component.check_navigation_finished() == true:
		Transitioned.emit(self,"idle")
	var movement_input = get_movement_input()
	
	if move_component.distance_from_origin() == true :
		Transitioned.emit(self,"retreat")
	
	
	#if target_manager.detect_player():
		#Transitioned.emit(self,"attack")
	move_component.move_and_slide_navigation((movement_input+parent.knockback )* SPEED)
	parent.knockback = lerp(parent.knockback, Vector2.ZERO, 0.2)
	

func exit():
	move_component.timer.stop()
