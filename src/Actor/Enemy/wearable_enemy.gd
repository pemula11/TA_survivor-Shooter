extends Actor


var direction : Vector2 = Vector2.ZERO
var isdead : bool = false
@onready var sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var nav_agent = $NavigationAgent2D as NavigationAgent2D
var player
@onready var state_machine  = $StateMachine 
@onready var move_component = $AI/MoveComponent

@onready var line_of_sight = $LineOfSight
@onready var attackdetector = $AttackDetector
@onready var target_manager = $AI/TargetManager
@onready var target_detector = $TargetDetector


@export var max_patrol = 200
@export var max_target_seen = 200
@export var max_target_detactor = 100
@onready var label = $Label
var knockback = Vector2.ZERO


@export var damage_bullet : int = 20
@export var distance_bullet : int = 200
@export var BULLET_SPEED : int = 100

var target_in_area : bool = false

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	move_component.init(nav_agent, player, self, max_patrol, global_position)
	state_machine.init(self,animation_player, move_component,sprite)
	#line_of_sight.target_position.x = max_target_seen
	target_detector.target_position.x = max_target_seen
	target_manager.init(self,line_of_sight, max_target_seen, player)
	

func _physics_process(delta):
	#if target_in_area:
	#	target_detector.look_at(player.global_position)
	state_machine.physics_process(delta)
	
func set_state(state):
	label.text = str(state)
