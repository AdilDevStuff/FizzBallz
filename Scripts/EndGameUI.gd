extends Control

# ---------- VARIABLES ---------- #

# NORMAL
export (String) var mainMenuPath

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

func _on_BackBtn_pressed():
	SoundManager.gameplayTrack.stop()
	SceneTransition.changeScene(mainMenuPath)
