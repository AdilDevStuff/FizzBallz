extends VBoxContainer

# ---------- VARIABLES ---------- #

# NORMAL
export (float) var tweenDuration
export (float) var marginRight
export (float) var marginLeft
export (float) var marginRightDefault
export (float) var marginLeftDefault

# BOOLEANS
var resumeBtnMouseHover = false
var menuBtnMouseHover = false
var exitBtnMouseHover = false

# VECTOR


# ONREADY
onready var resumeBtn = $ResumeBtn
onready var menuBtn = $MenuBtn
onready var exitBtn = $ExitBtn

# ---------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	pass

func _process(delta):
	if visible:
		resumeBtnHoverLeft()
		resumeBtnHoverRight()
		menuBtnHoverLeft()
		menuBtnHoverRight()
		exitBtnHoverLeft()
		exitBtnHoverRight()

func _physics_process(delta):
	pass

func _input(event):
	pass

# ---------- CUSTOM FUNCTIONS ---------- #

func resumeBtnHoverLeft():
	var tween = get_tree().create_tween()
	if resumeBtnMouseHover:
		tween.tween_property(resumeBtn, "margin_left", marginLeft, tweenDuration)
	else:
		tween.tween_property(resumeBtn, "margin_left", marginLeftDefault, tweenDuration)

func resumeBtnHoverRight():
	var tween = get_tree().create_tween()
	if resumeBtnMouseHover:
		tween.tween_property(resumeBtn, "margin_right", marginRight, tweenDuration)
	else:
		tween.tween_property(resumeBtn, "margin_right", marginRightDefault, tweenDuration)

func menuBtnHoverLeft():
	var tween = get_tree().create_tween()
	if menuBtnMouseHover:
		tween.tween_property(menuBtn, "margin_left", marginLeft, tweenDuration)
	else:
		tween.tween_property(menuBtn, "margin_left", marginLeftDefault, tweenDuration)

func menuBtnHoverRight():
	var tween = get_tree().create_tween()
	if menuBtnMouseHover:
		tween.tween_property(menuBtn, "margin_right", marginRight, tweenDuration)
	else:
		tween.tween_property(menuBtn, "margin_right", marginRightDefault, tweenDuration)

func exitBtnHoverLeft():
	var tween = get_tree().create_tween()
	if exitBtnMouseHover:
		tween.tween_property(exitBtn, "margin_left", marginLeft, tweenDuration)
	else:
		tween.tween_property(exitBtn, "margin_left", marginLeftDefault, tweenDuration)

func exitBtnHoverRight():
	var tween = get_tree().create_tween()
	if exitBtnMouseHover:
		tween.tween_property(exitBtn, "margin_right", marginRight, tweenDuration)
	else:
		tween.tween_property(exitBtn, "margin_right", marginRightDefault, tweenDuration)


# ---------- SIGNALS ---------- #

# MOUSE ENTERED
func _on_ResumeBtn_mouse_entered():
	resumeBtnMouseHover = true

func _on_MenuBtn_mouse_entered():
	menuBtnMouseHover = true

func _on_ExitBtn_mouse_entered():
	exitBtnMouseHover = true

# MOUSE EXITED
func _on_ResumeBtn_mouse_exited():
	resumeBtnMouseHover = false

func _on_MenuBtn_mouse_exited():
	menuBtnMouseHover = false

func _on_ExitBtn_mouse_exited():
	exitBtnMouseHover = false
