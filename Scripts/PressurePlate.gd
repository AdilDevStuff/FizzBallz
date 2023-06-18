extends KinematicBody2D

# ---------- VARIABLES ---------- #

# NORMAL


# BOOLEANS


# VECTOR


# ONREADY
onready var btnSprite = $Button/Sprite


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

func _on_Button_body_entered(body):
	if body.is_in_group("Pickable"):
		var tween = get_tree().create_tween()
		tween.tween_property(btnSprite, "scale", Vector2(1, 0.3), 0.1)
		get_tree().call_group("Door", "openDoor")

func _on_Button_body_exited(body):
	if body.is_in_group("Pickable"):
		var tween = get_tree().create_tween()
		tween.tween_property(btnSprite, "scale", Vector2(1, 1), 0.1)
		get_tree().call_group("Door", "closeDoor")
