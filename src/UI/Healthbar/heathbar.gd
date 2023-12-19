extends TextureRect

@onready var progress_bar = $ProgressBar
@export var healthcomponent : Node2D
var max_health
# Called when the node enters the scene tree for the first time.
func _ready():
	healthcomponent.health_changed.connect(change_value)
	max_health = healthcomponent.max_health
	progress_bar.max_value = max_health
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_value(health):
	
	progress_bar.value = health*max_health/100
	
