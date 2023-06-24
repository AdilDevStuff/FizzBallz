extends Control

# ---------- VARIABLES ---------- #

# NORMAL


# BOOLEANS


# VECTOR


# ONREADY
onready var pauseMenuAnims = $PauseMenuAnims

# ---------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	visible = false

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and !visible and !pauseMenuAnims.is_playing():
		pauseMenuAnims.play("Enter")

func _physics_process(delta):
	pass

func _input(event):
	pass

# ---------- CUSTOM FUNCTIONS ---------- #


# ---------- SIGNALS ---------- #

func _on_ResumeBtn_pressed():
	SoundManager.UIClickSFX.play()
	pauseMenuAnims.play_backwards("Enter")
	yield(pauseMenuAnims, "animation_finished")
	visible = false

func _on_MenuBtn_pressed():
	SoundManager.UIClickSFX.play()
	pauseMenuAnims.play_backwards("Enter")
	SceneTransition.changeScene("res://Scenes/UI/MainMenu.tscn")

func _on_ExitBtn_pressed():
	SoundManager.UIClickSFX.play()
	pauseMenuAnims.play_backwards("Enter")
	yield(pauseMenuAnims, "animation_finished")
	get_tree().quit()
