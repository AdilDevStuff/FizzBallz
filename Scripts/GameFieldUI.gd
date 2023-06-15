extends Control

# ---------- VARIABLES ---------- #

# NORMAL



# BOOLEANS


# VECTOR


# ONREADY
onready var hud = $HUD
onready var player = get_tree().get_root().get_child(0).find_node("Player")
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

func updateUI():
	if player.picked == true:
		hud.text = "Picked Up The Object" 


# ---------- SIGNALS ---------- #
