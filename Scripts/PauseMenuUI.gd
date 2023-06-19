extends Control

# ---------- VARIABLES ---------- #

# NORMAL


# BOOLEANS


# VECTOR


# ONREADY
onready var pauseMenuAnims = $PauseMenuAnims
onready var mainMenuUI = $"../../MainMenu/MainMenuUI"

# ---------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	visible = false

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and !mainMenuUI.visible and !visible and !pauseMenuAnims.is_playing():
		pauseMenuAnims.play("Enter")

func _physics_process(delta):
	pass

func _input(event):
	pass

# ---------- CUSTOM FUNCTIONS ---------- #


# ---------- SIGNALS ---------- #

func _on_ResumeBtn_pressed():
	pauseMenuAnims.play_backwards("Enter")
	yield(pauseMenuAnims, "animation_finished")
	visible = false

func _on_MenuBtn_pressed():
	pauseMenuAnims.play_backwards("Enter")
	SceneTransition.reloadScene()

func _on_ExitBtn_pressed():
	pauseMenuAnims.play_backwards("Enter")
	yield(pauseMenuAnims, "animation_finished")
	get_tree().quit()
