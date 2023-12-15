extends Enemy

@export var weapon : PackedScene

var current_weapon

func _ready():
	current_weapon = weapon.instantiate()
	
	super()

func _physics_process(delta):
	super(delta)
	
