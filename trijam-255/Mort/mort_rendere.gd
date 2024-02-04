extends Node2D

var _initial_scale = 1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")
	_initial_scale = $AnimatedSprite2D.scale

func _on_mortocycle_start_attack():
	print("attahuahduilzd")
	$AnimatedSprite2D.play("ark")
	


func _on_animated_sprite_2d_animation_finished():
	if ($AnimatedSprite2D as AnimatedSprite2D).animation == "ark":
		$AnimatedSprite2D.play("default")
	

func _on_mortocycle_start_jump():
	var tween = get_tree().create_tween()
	$AnimatedSprite2D.scale = _initial_scale * Vector2(1.3,0.7)
	tween.tween_property($AnimatedSprite2D,"scale",_initial_scale * Vector2(1.0,1.0),0.3).set_trans(Tween.TRANS_BOUNCE)
