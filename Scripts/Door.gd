extends KinematicBody2D

# ---------- VARIABLES ---------- #

# NORMAL


# BOOLEANS


# VECTOR


# ONREADY
onready var animPlayer = $AnimationPlayer


# ---------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	pass

func _input(event):
	pass

# ---------- CUSTOM FUNCTIONS ---------- #

func openDoor():
	animPlayer.play("DoorOpen")

func closeDoor():
	animPlayer.play_backwards("DoorOpen")

# ---------- SIGNALS ---------- #
