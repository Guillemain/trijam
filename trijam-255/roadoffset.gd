extends Polygon2D

@export var vitesse_defil = 1000.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (%Level.isLevelMoving):
		texture_offset.x = texture_offset.x + delta * %Level.speed * %Level.currentSpeedFactor
