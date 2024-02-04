extends AnimatableBody2D
class_name Peon

enum EPeonType {DEVIL, INNOCENT}
@export var peonType := EPeonType.INNOCENT

var isAlive := true
signal isKilled

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func hit():
	if isAlive:
		isAlive = false
		isKilled.emit()
		print("Peon killed")
