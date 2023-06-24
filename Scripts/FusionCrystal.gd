extends Area2D

# ---------- VARIABLES ---------- #

# NORMAL



# BOOLEANS


# VECTOR


# ONREADY
onready var animations = $Animations

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

func _on_FusionCrystal_body_entered(body):
	if body.name == "Player":
		get_tree().call_group("GameUI", "addCrystal")
		animations.play("Collected")
		SoundManager.fusionCrystalSFX.play()
		yield(animations, "animation_finished")
		queue_free()
