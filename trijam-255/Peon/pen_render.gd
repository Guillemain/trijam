extends Node2D

const died_effct := preload("res://Peon/died_effect.tscn")

var mechant: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	mechant = get_parent().peonType == 0
	
	if(mechant):
		$AnimatedSprite2D.animation = "mechant"
		($AnimatedSprite2D as AnimatedSprite2D).modulate = Color.INDIAN_RED
	$AnimatedSprite2D.frame = randi_range(0,3) # inclusive 



func _on_peon_is_killed():
	$AnimatedSprite2D.animation = "dead"
	var efx = died_effct.instantiate()
	
	get_parent().get_parent().add_child(efx)
	efx.global_position = global_position
