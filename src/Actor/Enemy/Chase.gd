extends State



@export var target_manager : TargetManager

func enter() -> void:
	
	super()
	move_component.timer.start()
	move_component.make_path()
	parent.set_state(get_state_name())
	#move_component.nav_agent.target_position = player.global_position
	
func physics_update(delta):
	
	
	var movement_input = get_movement_input()
	
	if move_component.distance_from_origin() == true :
		Transitioned.emit(self,"retreat")
	if  check_has_target() == false:
		Transitioned.emit(self,"idle")
	#if target_manager.detect_player():
		#Transitioned.emit(self,"attack")
	move_component.move_and_slide_navigation(movement_input * SPEED)
	

func exit():
	move_component.timer.stop()
