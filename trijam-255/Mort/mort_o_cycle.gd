extends CharacterBody2D

@export_group("Movement")
@export var JUMP_VELOCITY := -600.0
signal startJump

@export_group("Attack")
var isAttacking := false
signal startAttack
signal stopAttack

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		startJump.emit()
		
	move_and_slide()

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
