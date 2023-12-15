extends Base_state

var weapon : Weapon
var shot_position: Marker2D
var muzzle : Sprite2D
@onready var interval_shoot = $Interval_shoot


func enter():
	weapon.set_label("fire")
	shoot()

func process_input(event: InputEvent):
	if event.get_action_strength("shot") == 0:
		Transitioned.emit(self, "idle")

func shoot():
	if weapon.slot > 0:
		
		weapon.bullet_fire = clampi(weapon.slot, 1, weapon.BULLETS)
		for i in weapon.bullet_fire:
			weapon.muzzle.show()
			var bullet_instance = weapon.bullet.instantiate()
			var post =  shot_position.global_position+Vector2(0, 0).rotated(weapon.rotation)
			var target = (weapon.get_global_mouse_position()- post).normalized()
			bullet_instance.init(null, target, weapon.DAMAGE, 
								shot_position.global_position,
								weapon.BULLET_SPEED, 
								weapon.KNOCKBACK, 20)
			weapon.bullet_container.add_child(bullet_instance)
			interval_shoot.start()
			await interval_shoot.timeout
			weapon.slot -= 1
		
			weapon.muzzle.hide()
		weapon.can_shoot = false
		
		weapon.shot_weapon_time.start()
		weapon.set_label()
