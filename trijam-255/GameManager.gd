extends Node2D

@export var tuto : Node2D

@export var score := 0
@export var scoreDevil := 100
@export var scoreDelta := 5
var timeElapsed := 0.0

var gameStarted := false
signal gameStart

signal endOfGame(String)

# Called when the node enters the scene tree for the first time.
func _ready():
	%Level.isLevelMoving = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !gameStarted:
		if Input.is_action_pressed("attack"):
			startGame()
		return
		
	# raise score every second
	timeElapsed += delta
	if timeElapsed >= 0.25:
		timeElapsed = 0
		score += scoreDelta

	%Score.text = str(score)
	

func PeonSlayed(type : Peon.EPeonType):
	if type == Peon.EPeonType.DEVIL:
		print("Killed DEVIL")
		score += scoreDevil
	else:
		print("Killed INNOCENT")
		endOfGame.emit("You killed an INNOCENT Soul...")


func trunkHit():
	endOfGame.emit("You fell and broke your femur... Outch !")


func startGame():
	gameStart.emit()
	gameStarted = true
	%Level.isLevelMoving = true
