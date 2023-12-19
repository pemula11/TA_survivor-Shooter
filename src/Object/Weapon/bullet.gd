extends Area2D
class_name  Bullet

var ACCELL = 10

@export  var DAMAGE : int = 1
@export  var SPEED :float = 500
@export  var push_force :float = 80
@export var owner_bullet : CharacterBody2D
@export var KNOCKBACK_FORCE = 1
var max_distance = 400
var origin

var direction := Vector2.ZERO

var velocity

func init(owners, directions, damage, pos, speed, knockback, max_distances):
	owner_bullet = owners
	direction = directions
	position = pos
	DAMAGE = damage
	#KNOCKBACK_FORCE = knockback
	max_distance = max_distances
	origin = pos
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	
	position += (direction* SPEED) *delta
	if (origin - position).length() > max_distance*10:
		queue_free()
	


func _on_body_entered(body):
	
		queue_free()


func _on_area_entered(area):
	if area and area.has_method("take_damage"):
		var knockback_dir = global_position.direction_to(area.global_position)
		area.take_damage(DAMAGE, knockback_dir*KNOCKBACK_FORCE)
	
		queue_free()
