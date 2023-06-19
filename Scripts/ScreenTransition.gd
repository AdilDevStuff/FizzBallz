extends CanvasLayer

# ---------- VARIABLES ---------- #

# NORMAL



# BOOLEANS


# VECTOR


# ONREADY
onready var screenTransAnim = $ScreenTransAnim


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

func changeScene(target: String) -> void:
	screenTransAnim.play("Fade")
	yield(screenTransAnim, "animation_finished")
	get_tree().change_scene(target)
	screenTransAnim.play_backwards("Fade")

func reloadScene() -> void:
	screenTransAnim.play("Fade")
	yield(screenTransAnim, "animation_finished")
	get_tree().reload_current_scene()
	screenTransAnim.play_backwards("Fade")

# ---------- SIGNALS ---------- #
