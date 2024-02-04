extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
		$AnimatedSprite2D.play("default")

func _on_mortocycle_start_attack():
	print("attahuahduilzd")
	$AnimatedSprite2D.play("ark")



func _on_animated_sprite_2d_animation_finished():
	if ($AnimatedSprite2D as AnimatedSprite2D).animation == "ark":
		$AnimatedSprite2D.play("default")
