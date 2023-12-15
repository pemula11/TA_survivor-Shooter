extends Area2D
class_name  Bullet

var ACCELL = 10

@export  var DAMAGE : int = 1
@export  var SPEED :float = 10
@export  var push_force :float = 80
@export var owner_bullet : CharacterBody2D
@export var KNOCKBACK = 0
var max_distance = 400
var origin

var direction := Vector2.ZERO

var velocity

func init(owner, directions, damage, pos, speed, knockback, max_distances):
	owner_bullet = owner
	direction = directions
	position = pos
	DAMAGE = damage
	KNOCKBACK = knockback
	max_distance = max_distances
	origin = pos
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	
	position += (direction* SPEED) * 30 *delta
	if (origin - position).length() > max_distance*10:
		queue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group('enemy'):
		print("hit")
		queue_free()



func _on_body_entered(body):
	if body.is_in_group('enemy'):
		print("hit")
		queue_free()
