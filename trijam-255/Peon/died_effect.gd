extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	play_died()

func play_died():
	$Explosion.play("default")
	$Ame.play("default")
	var tween := get_tree().create_tween()
	tween.tween_property($Ame,"position",$Ame.position + Vector2.UP * 500,0.5).set_ease(Tween.EASE_IN)
	tween.tween_callback(queue_free)
