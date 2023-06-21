extends Control

# ---------- VARIABLES ---------- #

# NORMAL


# BOOLEANS


# VECTOR


# ONREADY
onready var menuAnims = $MenuAnims
onready var creditsMenuUI = get_parent().get_node("CreditsMenuUI")

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

func _on_PlayBtn_pressed():
	menuAnims.play_backwards("Enter")
	SceneTransition.changeScene("res://Scenes/Levels/Level_01.tscn")

func _on_CreditsBtn_pressed():
	menuAnims.play_backwards("Enter")
	yield(menuAnims, "animation_finished")
	creditsMenuUI.creditsMenuAnims.play("Enter")

func _on_ExitBtn_pressed():
	menuAnims.play_backwards("Enter")
	yield(menuAnims, "animation_finished")
	get_tree().quit()
