extends AnimatableBody2D

signal hitATrunk

@export_group("Movement")
@export var jumpForce = 600
@export var normalGravity = -9.8
@export var stoppingGravity = -30.0 
@export var motionVector := Vector2(0.0, 0.0)
@export var isOnFloor := true
signal startJump
signal stopJump

var numberFrameJumpPressed := 0
const RECENT_JUMP_FRAME_NB := 5

@export_group("Attack")
var isAttacking := false
signal startAttack
signal stopAttack

func _ready():
	$ScytheArea.set_deferred("disabled", true)

func _physics_process(delta):
	if Input.is_action_pressed("jump"):
		numberFrameJumpPressed += 1
	else:
		numberFrameJumpPressed = 0
	
	# Add the gravity.
	if not isOnFloor:
		if !Input.is_action_pressed("jump") and motionVector.y > 0:
			motionVector.y += stoppingGravity * delta
		else:
			motionVector.y += normalGravity * delta

	# Handle jump.
	if isOnFloor and isJumpRecentlyPressed():
		motionVector.y = jumpForce
		isOnFloor = false
		startJump.emit()
		print("Jump")
		
	# Movze & check colision
	var collision_info := move_and_collide(-motionVector)
	if collision_info:
		# We collided
		var collider := collision_info.get_collider()
		# Check if trunk
		if collider.get_collision_layer_value(3):
			# We collided with trunk
			hitATrunk.emit()
			print("Hit a trunk")
		elif collider.get_collision_layer_value(2):
			# We collided with floor
			if !isOnFloor:
				isOnFloor = true
				motionVector.y = 0.0
				stopJump.emit()
				print("isOnFloor")

func _process(_delta):
	# Check attack
	if Input.is_action_just_pressed("attack") and !isAttacking:
		isAttacking = true
		startAttack.emit()
		$AttackDuration.start()
		$ScytheArea.set_deferred("disabled", false)
		print("Attack started")

func _on_attack_duration_timeout():
	isAttacking = false
	$ScytheArea.set_deferred("disabled", true)
	stopAttack.emit()

func isJumpRecentlyPressed():
	return Input.is_action_pressed("jump") and (numberFrameJumpPressed <= RECENT_JUMP_FRAME_NB)
