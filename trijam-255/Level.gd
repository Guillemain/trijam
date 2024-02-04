extends Node2D

@export var speed:= 20.0
@export var isLevelMoving := false

@export_group("Trunk")
@export var minDelayTrunk := 0.5
@export var maxDelayTrunk := 2.0
@export var trunk : PackedScene



@export_group("Peon")
@export var minDelay := 0.3
@export var maxDelay := 2.5
@export_range(0.0, 1.0) var ProbaDevil := 0.33
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
		# move all of its childs.
		var motionVector := Vector2(-speed * delta, 0.0)
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
	if random_float < ProbaDevil:
		var instance = spawnSomething(devil) as Peon
		instance.isKilled.connect(%GameManager.PeonSlayed.bind(Peon.EPeonType.DEVIL))
	else:
		var instance = spawnSomething(innocent) as Peon
		instance.isKilled.connect(%GameManager.PeonSlayed.bind(Peon.EPeonType.INNOCENT))
		
	startNextPeonSpawnTimer()

func spawnTrunk():
	spawnSomething(trunk)
	startNextTrunkSpawnTimer()

func startNextTrunkSpawnTimer():
	# random time between minTime & MaxTime
	var rngDelay := minDelayTrunk + randf() * (maxDelayTrunk - minDelayTrunk)
	$TrunkTimer.start(rngDelay)
	
func startNextPeonSpawnTimer():
	# random time between minTime & MaxTime
	var rngDelay := minDelay + randf() * (maxDelay - minDelay)
	$PeonTimer.start(rngDelay)
