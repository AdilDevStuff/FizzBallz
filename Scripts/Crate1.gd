extends KinematicBody2D

# ---------- VARIABLES ---------- #

# NORMAL
export (float) var gravity = 30

# BOOLEANS


# VECTOR
var velocity := Vector2.ZERO

# ONREADY


# ---------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	velocity.y += gravity
	velocity = move_and_slide(velocity)

func _input(event):
	pass

# ---------- CUSTOM FUNCTIONS ---------- #



# ---------- SIGNALS ---------- #
