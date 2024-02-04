extends Node2D

@export var tuto : Node2D

@export var score := 0
@export var scoreDevil := 100
@export var scoreDelta := 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func PeonSlayed(type : Peon.EPeonType):
	if type == Peon.EPeonType.DEVIL:
		print("Killed DEVIL")
	else:
		print("Killed INNOCENT")


func trunkHit():
	pass

func endOfGame():
	pass
