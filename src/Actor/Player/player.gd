extends Actor
class_name Player

@export var Weapon : PackedScene
@export var Weapon2 : PackedScene

var direction : Vector2 = Vector2.ZERO
var isdead : bool = false
var current_weapon 

@onready var animation_player = $AnimationPlayer
@onready var move_component = $MoveComponent
@onready var state_machine = $StateMachine
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var label = $Label

@onready var bullet_container

var knockback = Vector2.ZERO
var knockback_force = 80

func _ready():
	bullet_container = get_node("%BulletContainer")
	print(bullet_container)
	state_machine.init(self, animation_player, move_component, animated_sprite_2d)
	if Weapon != null:
		print("ok")
		current_weapon = Weapon.instantiate()
		
		add_child(current_weapon)
		current_weapon.init(bullet_container)

func _physics_process(delta):
	var pos = get_global_mouse_position()
	var actualpos = (pos - global_position).normalized() 

	if actualpos.x < 0:
		
		if current_weapon != null:
			current_weapon.scale.x = -1
			current_weapon.rotation = pos.angle_to_point(position) + 270
		
	elif actualpos.x > 0:
		
		if current_weapon != null:
			current_weapon.scale.x = 1
			current_weapon.rotation = position.angle_to_point(pos)
	
	#velocity.x = move_toward(velocity.x, SPEED * movement_input.x, 10)
	#velocity.y = move_toward(velocity.y, SPEED * movement_input.y, 10)
	#move_and_slide()
	state_machine.physics_process(delta)

func _process(delta):
	
	state_machine.process(delta)
	
func _unhandled_input(event):
	state_machine._unhandled_input(event)
	if Input.is_action_just_pressed("change_weapon"):
		if current_weapon.weapon_name == "pistol":
			current_weapon.queue_free()
			current_weapon = Weapon2.instantiate()
			current_weapon.init(bullet_container)
			add_child(current_weapon)
		elif current_weapon.weapon_name == "AR":
			current_weapon.queue_free()
			current_weapon = Weapon.instantiate()
			current_weapon.init(bullet_container)
			add_child(current_weapon)
	
	
func set_state(state):
	label.text = str(state)


func _on_hurtbox_area_entered(area):
	var source = area.get_parent()
	var dir = global_position.direction_to(source.global_position)
	knockback = dir * -1
