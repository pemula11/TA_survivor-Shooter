extends StaticBody2D
class_name  Weapon
#bullet variable 
@export var weapon_name : String = "weapon"
@export var BULLET_SPEED : float = 100
@export var SHOOT_RAGE : float = 700
@export var BULLET_SIZE : int = 1
@export var KNOCKBACK : float = 0
@export var BULLETS : int = 1  #jumlah bullet dikeluarkan
@export var DAMAGE : int = 50


@export var SHOOT_WEAPON_TIME = 0.5
@export var INTERVAL_BULLET = 0.05
@export var RELOAD_WEAPON_TIME = 2

@export var bullet :PackedScene
@export var slot : int # slot di senjata
@export var max_slot : int # max slot reload senjata
@export var ammo : int 

@export var cd_attack :float
@export var cd_reload :float

var PLAYER = null
var ENEMY = null

@onready var shot_position = $ShotPosition
@onready var sprite = $Sprite2D
@onready var muzzle = $Muzzle

@onready var shot_weapon_time = $Shot_weapon_time
@onready var interval_bullet = $Interval_bullet
@onready var reload_weapon_time = $Reload_weapon_time
@onready var label = $CanvasLayer/Label


enum WeaponState {
	Idle,
	Firing,
	Reload
}

var current_state: WeaponState = WeaponState.Idle


var can_shoot : bool = true
var state_change_timer

var bullet_fire
var bullet_container

func init(bullet_containers):
	
	bullet_container = bullet_containers

# Called when the node enters the scene tree for the first time.
func _ready():
#	label.text = "ammo %s slot %s \n aaa" % [str(ammo), str(slot)]
#	state_machine.init(self, shot_position, muzzle)
	shot_weapon_time.wait_time = SHOOT_WEAPON_TIME
	interval_bullet.wait_time = INTERVAL_BULLET
	reload_weapon_time.wait_time = RELOAD_WEAPON_TIME
	
func _physics_process(delta):
	pass
	

func change_state(new_state: WeaponState):
	current_state = new_state
	match current_state:
		WeaponState.Idle:
			set_label("idle")
		WeaponState.Firing:
			set_label("firing")
			shot()
			change_state(WeaponState.Idle)
		WeaponState.Reload:
			#state_change_timer = RELOAD_WEAPON_TIME
			set_label("reload")
			reload_weapon_time.start()

func _unhandled_input(event):
	pass

func _process(delta):
	match current_state:
		WeaponState.Idle:
			if Input.get_action_strength("shot") == 1 and can_shoot:
				change_state(WeaponState.Firing)
			if Input.is_action_just_pressed("reload") and ammo > 0:
				change_state(WeaponState.Reload)
		WeaponState.Firing:
			if Input.get_action_strength("shot") == 1 and can_shoot:
				change_state(WeaponState.Firing)
		WeaponState.Reload:
			pass
			
	

func shot():
	if slot > 0:
		
		bullet_fire = clampi(slot, 1, BULLETS)
		can_shoot = false
		for i in bullet_fire:
			muzzle.show()
			var bullet_instance = bullet.instantiate()
			var post =  shot_position.global_position+Vector2(0, 0).rotated(rotation)
			var target = (get_global_mouse_position()- post).normalized()
			bullet_instance.init(null, target, DAMAGE, shot_position.global_position, BULLET_SPEED, 
								KNOCKBACK, 20)
			#bullet_container.add_child(bullet_instance)
			SignalManager.emit_signal("shoot_target", bullet_instance)
			interval_bullet.start()
			await interval_bullet.timeout
			slot -= 1
		
			muzzle.hide()
		
		
		shot_weapon_time.start()
	
		
func _reload():
	if Input.is_action_just_pressed("reload") and ammo > 0:
		can_shoot = false
		reload_weapon_time.start()


func _on_reload_weapon_time_timeout():
	var tmp = ammo + slot
	slot = max_slot
	ammo = tmp - max_slot
	can_shoot = true
	print("reloaded")
	
	change_state(WeaponState.Idle)


func _on_shot_weapon_time_timeout():
	can_shoot = true

func set_label(state = "none"):
	label.text = "ammo %s slot %s \n state %s" % [str(ammo), str(slot), state]
