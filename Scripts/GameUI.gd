extends Control

# ---------- VARIABLES ---------- #

# NORMAL
var crystals = 0

# BOOLEANS


# VECTORd


# ONREADY
onready var crystalsLabel = $CrystalsLabel
onready var crystal = $Crystals

# ---------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	pass

func _process(delta):
		if get_tree().current_scene.is_in_group("TutorialLevels"):
			crystal.visible = false
			crystalsLabel.visible = false
		else:
			crystal.visible = true
			crystalsLabel.visible = true
			crystalsLabel.text = "%.d/1" % crystals

func _physics_process(delta):
	pass

func _input(event):
	pass

# ---------- CUSTOM FUNCTIONS ---------- #

func addCrystal():
	crystals += 1

# ---------- SIGNALS ---------- #
