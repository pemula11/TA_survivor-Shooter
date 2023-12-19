extends Area2D

@export var health_component : HealthComponet
@export var actor : Actor

func take_damage(amount, knockback_dir, effect = null):
	health_component.damage(amount, effect)
	if actor != null and actor.can_knockback:
		knockback(knockback_dir)

func knockback(knockback_dir):
	
	actor.knockback = knockback_dir 
	
