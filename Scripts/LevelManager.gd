extends Node2D

# ---------- VARIABLES ---------- #

# NORMAL
export (String) var nextLevelPath

# BOOLEANS


# VECTOR


# ONREADY


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



# ---------- SIGNALS ---------- #

func _on_LevelFinish_body_entered(body):
	if body.name == "Player":
		SceneTransition.changeScene(nextLevelPath)
