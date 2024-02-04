extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(cutPeon)

func cutPeon(object):
	if object is Peon:
		print("Peon Cutted : " + object.get_name())
		object.hit()
