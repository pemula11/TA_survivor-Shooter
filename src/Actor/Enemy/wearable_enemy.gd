extends Enemy

@export var weapon : PackedScene


var current_weapon
@export var has_projectile : bool

func _ready():
	super()
	if weapon != null:
		current_weapon = weapon.instantiate()
	
	

func _physics_process(delta):
	super(delta)
	
func shoot():
	pass


