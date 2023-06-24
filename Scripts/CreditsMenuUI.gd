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
var metaHovered = false

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
	SoundManager.UIClickSFX.play()
	OS.shell_open(str(meta))

func _on_BackBtn_pressed():
	SoundManager.UIClickSFX.play()
	creditsMenuAnims.play_backwards("Enter")
	yield(creditsMenuAnims, "animation_finished")
	mainMenuUI.menuAnims.play("Enter")
	visible = false

func _on_RichTextLabel_meta_hover_started(meta):
	SoundManager.UIHoverSFX.play()
	metaHovered = true

func _on_RichTextLabel_meta_hover_ended(meta):
	metaHovered = false

func _on_BackBtn_mouse_entered():
	SoundManager.UIHoverSFX.play()
	backBtnHover = true

func _on_BackBtn_mouse_exited():
	backBtnHover = false
