extends Path2D
class_name spikeBall

# ---------- VARIABLES ---------- #

# NORMAL



# BOOLEANS


# VECTOR


# ONREADY
onready var spikeBall = $PathFollow2D/SpikeBall

# ---------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	pass

func _process(delta):
	spikeBall.rotation_degrees += 4

func _physics_process(delta):
	pass

func _input(event):
	pass

# ---------- CUSTOM FUNCTIONS ---------- #



# ---------- SIGNALS ---------- #

func _on_SpikeBall_body_entered(body):
	if body.name == "Player":
		body.isDead = true
		body.playerAnims.play("Death")
