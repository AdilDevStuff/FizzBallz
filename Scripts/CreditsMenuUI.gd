extends Control

# ---------- VARIABLES ---------- #

# NORMAL
export (float) var tweenDuration
export (float) var marginRight = 840
export (float) var marginLeft = 600
export (float) var marginRightDefault = 825
export (float) var marginLeftDefault = 622


# BOOLEANS
var backBtnHover = false

# VECTOR


# ONREADY
onready var creditsMenuAnims = $MenuAnims
onready var mainMenuUI = $"../../MainMenu/MainMenuUI"
onready var backBtn = $BackBtn

# ---------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	visible = false

func _process(delta):
	backBtnMarginLeftHover()
	backBtnMarginRightHover()

func _physics_process(delta):
	pass

func _input(event):
	pass

# ---------- CUSTOM FUNCTIONS ---------- #

func backBtnMarginLeftHover():
	if !creditsMenuAnims.is_playing():
		var tween = get_tree().create_tween()
		if backBtnHover:
			tween.tween_property(backBtn, "margin_left", marginLeft, tweenDuration)
		else:
			tween.tween_property(backBtn, "margin_left", marginLeftDefault, tweenDuration)

func backBtnMarginRightHover():
	if !creditsMenuAnims.is_playing():
		var tween = get_tree().create_tween()
		if backBtnHover:
			tween.tween_property(backBtn, "margin_right", marginRight, tweenDuration)
		else:
			tween.tween_property(backBtn, "margin_right", marginRightDefault, tweenDuration)

# ---------- SIGNALS ---------- #

func _on_RichTextLabel_meta_clicked(meta):
	OS.shell_open(str(meta))

func _on_BackBtn_pressed():
	creditsMenuAnims.play_backwards("Enter")
	mainMenuUI.visible = true
	mainMenuUI.menuAnims.play("Enter")
	yield(creditsMenuAnims, "animation_finished")
	self.visible = false

func _on_BackBtn_mouse_entered():
	backBtnHover = true

func _on_BackBtn_mouse_exited():
	backBtnHover = false
