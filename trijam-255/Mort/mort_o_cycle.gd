extends AnimatableBody2D

signal hitATrunk

@export_group("Movement")
@export var jumpForce = 600
@export var normalGravity = -9.8
@export var stoppingGravity = -30.0 
@export var motionVector := Vector2(0.0, 0.0)
@export var isOnFloor := true
signal startJump

@export_group("Attack")
var isAttacking := false
signal startAttack
signal stopAttack

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not isOnFloor:
		if !Input.is_action_pressed("jump") and motionVector.y > 0:
			motionVector.y += stoppingGravity * delta
		else:
			motionVector.y += normalGravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and isOnFloor:
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
			isOnFloor = true
			motionVector.y = 0.0
			print("isOnFloor")

func _process(_delta):
	# Check attack
	if Input.is_action_just_pressed("attack") and !isAttacking:
		isAttacking = true
		startAttack.emit()
		$AttackDuration.start()
		print("Attack started")

func _on_attack_duration_timeout():
	isAttacking = false
	stopAttack.emit()

