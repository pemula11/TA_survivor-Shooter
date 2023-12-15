extends Actor
class_name Enemy

var direction : Vector2 = Vector2.ZERO
var isdead : bool = false
@onready var sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var nav_agent = $NavigationAgent2D as NavigationAgent2D
var player
@onready var state_machine :Character_State_Machine = $StateMachine 
@onready var move_component = $AI/MoveComponent

@onready var line_of_sight = $LineOfSight

@export var max_patrol = 200
@export var max_target_seen = 200
@onready var label = $Label

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	move_component.init(nav_agent, player, self, max_patrol, global_position)
	state_machine.init(self,animation_player, move_component,sprite)
	line_of_sight.target_position.x = max_target_seen
	

func _physics_process(delta):
	line_of_sight.look_at(player.global_position)
	state_machine.physics_process(delta)
	
func set_state(state):
	label.text = str(state)
