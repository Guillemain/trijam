extends Node2D

@export var speed:= 20.0
@export var isLevelMoving := false

@export_group("Objects to spawn")
@export var trunk : PackedScene
@export_range(0.0, 100.0) var ProbaTrunk := 25
@export var devil : PackedScene
@export_range(0.0, 100.0) var ProbaDevil := 33
@export var innocent : PackedScene

@export_group("Spawn time")
@export var minDelay := 0.5
@export var maxDelay := 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	startNextSpawnTimer()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if isLevelMoving:
		# move all of its childs.
		var motionVector := Vector2(-speed, 0.0)
		for child in $ToMove.get_children():
			if child is PhysicsBody2D:
				child.move_and_collide(motionVector)

func spawnSomething(sceneToSpawn : PackedScene):
	var instance = sceneToSpawn.instantiate()
	instance.position = $Spawn.position
	$ToMove.add_child(instance)

func randomSpawn():
	spawnSomething(trunk)
	startNextSpawnTimer()

func startNextSpawnTimer():
	# random time between minTime & MaxTime
	var rngDelay := minDelay + randf() * (maxDelay - minDelay)
	$SpawnTimer.start(rngDelay)
