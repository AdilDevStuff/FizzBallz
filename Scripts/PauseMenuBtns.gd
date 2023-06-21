extends VBoxContainer

# ---------- VARIABLES ---------- #

# NORMAL
export (float) var tweenDuration = 0.3
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
		resumeBtnHover(delta)
		menuBtnHover(delta)
		exitBtnHover(delta)

func _physics_process(delta):
	pass

func _input(event):
	pass

# ---------- CUSTOM FUNCTIONS ---------- #

func resumeBtnHover(delta):
	if resumeBtnMouseHover:
		resumeBtn.margin_left = lerp(resumeBtn.margin_left, marginLeft, tweenDuration)
		resumeBtn.margin_right = lerp(resumeBtn.margin_right, marginRight, tweenDuration)
	else:
		resumeBtn.margin_left = lerp(resumeBtn.margin_left, marginLeftDefault, tweenDuration)
		resumeBtn.margin_right = lerp(resumeBtn.margin_right, marginRightDefault, tweenDuration)

func menuBtnHover(delta):
	if menuBtnMouseHover:
		menuBtn.margin_right = lerp(menuBtn.margin_right, marginRight, tweenDuration)
		menuBtn.margin_left = lerp(menuBtn.margin_left, marginLeft, tweenDuration)
	else:
		menuBtn.margin_right = lerp(menuBtn.margin_right, marginRightDefault, tweenDuration)
		menuBtn.margin_left = lerp(menuBtn.margin_left, marginLeftDefault, tweenDuration)

func exitBtnHover(delta):
	if exitBtnMouseHover:
		exitBtn.margin_left = lerp(exitBtn.margin_left, marginLeft, tweenDuration)
		exitBtn.margin_right = lerp(exitBtn.margin_right, marginRight, tweenDuration)
	else:
		exitBtn.margin_left = lerp(exitBtn.margin_left, marginLeftDefault, tweenDuration)
		exitBtn.margin_right = lerp(exitBtn.margin_right, marginRightDefault, tweenDuration)

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
