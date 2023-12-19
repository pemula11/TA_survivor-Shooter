extends Area2D

@export var actor : CharacterBody2D
@export var damage_on_hit : int = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area and area.has_method("take_damage"):
		var knockback_dir = global_position.direction_to(area.global_position)
		area.take_damage(damage_on_hit, knockback_dir)
		
		
