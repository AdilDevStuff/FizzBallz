extends Area2D
class_name fuse

# ---------- VARIABLES ---------- #

# NORMAL
export (float) var speed = 2


# BOOLEANS
var isInRange = false

# VECTOR


# ONREADY
onready var player = get_tree().current_scene.find_node("Player")

# ---------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	pass

func _process(delta):
	if isInRange:
		followPlayer()

func _physics_process(delta):
	pass

func _input(event):
	pass

# ---------- CUSTOM FUNCTIONS ---------- #

func followPlayer():
	position += position.direction_to(player.position) * speed

# ---------- SIGNALS ---------- #

func _on_BeachBallFuse_body_entered(body):
	if body.name == "Player":
		pass

func _on_Range_body_entered(body):
	if body.name == "Player":
		isInRange = true

func _on_Range_body_exited(body):
	if body.name == "Player":
		isInRange = false
