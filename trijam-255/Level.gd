extends Node2D

@export var speed := 450.0
@export var currentSpeedFactor := 1.0
@export var accelerationSpeedFactor := 1.0 / 60.0
@export var isLevelMoving := false

# Ajoute d'Aune :
# j'aime pas avoir un peon sur un trunck

@export var proba_trunk = 0.5 # probability of trunk spawn instead of a peon.

@export_group("Trunk")
@export var minDelayTrunk := 0.8
@export var maxDelayTrunk := 2.2
@export var trunk : PackedScene



@export_group("Peon")
@export var minDelay := 0.3
@export var maxDelay := 2.2
@export_range(0.0, 1.0) var ProbaDevil := 0.7
@export var devil : PackedScene
@export var innocent : PackedScene




# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	startNextTrunkSpawnTimer()
	startNextPeonSpawnTimer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if isLevelMoving:
		currentSpeedFactor += accelerationSpeedFactor * delta
		
		# move all of its childs.
		var motionVector := Vector2(-speed * delta * currentSpeedFactor, 0.0)
		for child in $ToMove.get_children():
			if child is PhysicsBody2D:
				child.move_and_collide(motionVector)

func spawnSomething(sceneToSpawn : PackedScene) -> Node:
	var instance = sceneToSpawn.instantiate()
	instance.position = $Spawn.position
	$ToMove.add_child(instance)
	return instance

func randomPeonSpawn():
	# Chose what to spawn
	var random_float = randf()
	if random_float < proba_trunk:
		spawnSomething(trunk)
		startNextPeonSpawnTimer()
	else:
		random_float = randf()
		if random_float < ProbaDevil:
			var instance = spawnSomething(devil) as Peon
			instance.isKilled.connect(%GameManager.PeonSlayed.bind("DEVIL"))
		else:
			var instance = spawnSomething(innocent) as Peon
			instance.isKilled.connect(%GameManager.PeonSlayed.bind("INNOCENT"))
			
	startNextPeonSpawnTimer()

func spawnTrunk():
	pass
	#spawnSomething(trunk)
	#startNextTrunkSpawnTimer()

func startNextTrunkSpawnTimer():
	# random time between minTime & MaxTime
	var rngDelay := minDelayTrunk / currentSpeedFactor + randf() * (maxDelayTrunk / currentSpeedFactor)
	$TrunkTimer.start(rngDelay)
	
func startNextPeonSpawnTimer():
	# random time between minTime & MaxTime
	var rngDelay := minDelay / currentSpeedFactor + randf() * (maxDelay / currentSpeedFactor)
	$PeonTimer.start(rngDelay)
