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
onready var mainMenuUI = get_parent().get_node("MainMenuUI")
onready var backBtn = $BackBtn

# ---------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	visible = false

func _process(delta):
	backBtnMarginLeftHover(delta)
	backBtnMarginRightHover(delta)

func _physics_process(delta):
	pass

func _input(event):
	pass

# ---------- CUSTOM FUNCTIONS ---------- #

func backBtnMarginLeftHover(delta):
	if !creditsMenuAnims.is_playing():
		if backBtnHover:
			backBtn.margin_left = lerp(backBtn.margin_left, marginLeft, tweenDuration * delta)
		else:
			backBtn.margin_left = lerp(backBtn.margin_left, marginLeftDefault, tweenDuration * delta)

func backBtnMarginRightHover(delta):
	if !creditsMenuAnims.is_playing():
		if backBtnHover:
			backBtn.margin_right = lerp(backBtn.margin_right, marginRight, tweenDuration * delta)
		else:
			backBtn.margin_right = lerp(backBtn.margin_right, marginRightDefault, tweenDuration * delta)

# ---------- SIGNALS ---------- #

func _on_RichTextLabel_meta_clicked(meta):
	OS.shell_open(str(meta))

func _on_BackBtn_pressed():
	creditsMenuAnims.play_backwards("Enter")
	yield(creditsMenuAnims, "animation_finished")
	mainMenuUI.menuAnims.play("Enter")
	visible = false

func _on_BackBtn_mouse_entered():
	backBtnHover = true

func _on_BackBtn_mouse_exited():
	backBtnHover = false
