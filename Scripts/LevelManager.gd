extends Node2D

# ---------- VARIABLES ---------- #

# NORMAL
export (String) var nextLevelPath

# BOOLEANS
var isInSwitchZone = false

# VECTOR


# ONREADY
onready var player = get_tree().get_root().get_child(2).find_node("Player")


# ---------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	pass

func _process(delta):
	if get_tree().current_scene.name == "Level_01":
		player.canSwitch = false
	elif get_tree().current_scene.name == "Level_02" and !isInSwitchZone:
		player.canSwitch = false
	else:
		player.canSwitch = true

func _physics_process(delta):
	pass

func _input(event):
	pass

# ---------- CUSTOM FUNCTIONS ---------- #



# ---------- SIGNALS ---------- #

func _on_LevelFinish_body_entered(body):
	if body.name == "Player":
		SceneTransition.changeScene(nextLevelPath)

func _on_CanSwitch_body_entered(body):
	if body.name == "Player":
		isInSwitchZone = true
