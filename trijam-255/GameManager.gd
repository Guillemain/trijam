extends Node2D

@export var tuto : Node2D

@export var score := 0
@export var scoreDevil := 100
@export var scoreDelta := 5
var timeElapsed := 0.0

var gameStarted := false
signal gameStart

var isDead := false
signal endOfGame()

# Called when the node enters the scene tree for the first time.
func _ready():
	%Level.isLevelMoving = false
	$DeathPanel.visible = false
	$TutoPanel.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !gameStarted:
		if Input.is_action_pressed("attack"):
			startGame()
		return
	
	if isDead:
		if Input.is_action_pressed("restart"):
			restart()
		return
		
	# raise score every second
	timeElapsed += delta
	if timeElapsed >= 0.25:
		timeElapsed = 0
		score += scoreDelta

	%Score.text = str(score)
	

func PeonSlayed(type : String):
	if type == "DEVIL":
		print("Killed DEVIL")
		score += scoreDevil
	else:
		print("Killed INNOCENT")
		%DeathReason.text = "You killed an INNOCENT Soul..."
		endGame()


func trunkHit():
	%DeathReason.text = "You fell and broke your femur... Outch !"
	endGame()


func startGame():
	gameStart.emit()
	gameStarted = true
	%Level.isLevelMoving = true
	$TutoPanel.visible = false


func endGame():
	if isDead:
		return
		
	var tween = get_tree().create_tween()
	tween.tween_property($"../AudioStreamPlayer","pitch_scale",0.8,0.3)
	
	
	isDead = true
	%Level.isLevelMoving = false
	%FinalScore.text = %FinalScore.text + str(score)
	endOfGame.emit()
	$DeathPanel.visible = true

func restart():
	get_tree().reload_current_scene()
