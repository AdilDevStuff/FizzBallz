extends Control

# ---------- VARIABLES ---------- #

# NORMAL


# BOOLEANS


# VECTOR


# ONREADY
onready var menuAnims = $MenuAnims


# ---------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	visible = true

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
	yield(menuAnims, "animation_finished")
	self.visible = false

func _on_CreditsBtn_pressed():
	menuAnims.play_backwards("Enter")
	yield(menuAnims, "animation_finished")
	self.visible = false

func _on_ExitBtn_pressed():
	menuAnims.play_backwards("Enter")
	yield(menuAnims, "animation_finished")
	get_tree().quit()
