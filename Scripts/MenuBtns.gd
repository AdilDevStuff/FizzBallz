extends VBoxContainer

# ---------- VARIABLES ---------- #

# NORMAL


# BOOLEANS
var playBtnMouseHover = false
var creditsBtnMouseHover = false
var exitBtnMouseHover = false

# VECTOR


# ONREADY
onready var playBtn = $PlayBtn
onready var creditsBtn = $CreditsBtn
onready var exitBtn = $ExitBtn

onready var playBtnExpandMargin = get("expand_margin_right")

# ---------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	pass

func _process(delta):
	playBtnHover()
	creditsBtnHover()
	exitBtnHover()

func _physics_process(delta):
	pass

func _input(event):
	pass

# ---------- CUSTOM FUNCTIONS ---------- #

func playBtnHover():
	var tween = get_tree().create_tween()
	if playBtnMouseHover:
		tween.tween_property(playBtn, "margin_right", 260, 0.2)
	else:
		tween.tween_property(playBtn, "margin_right", 239, 0.2)

func creditsBtnHover():
	var tween = get_tree().create_tween()
	if creditsBtnMouseHover:
		tween.tween_property(creditsBtn, "margin_right", 260, 0.2)
	else:
		tween.tween_property(creditsBtn, "margin_right", 239, 0.2)

func exitBtnHover():
	var tween = get_tree().create_tween()
	if exitBtnMouseHover:
		tween.tween_property(exitBtn, "margin_right", 260, 0.2)
	else:
		tween.tween_property(exitBtn, "margin_right", 239, 0.2)

# ---------- SIGNALS ---------- #

# MOUSE ENTERED
func _on_PlayBtn_mouse_entered():
	playBtnMouseHover = true

func _on_CreditsBtn_mouse_entered():
	creditsBtnMouseHover = true

func _on_ExitBtn_mouse_entered():
	exitBtnMouseHover = true

# MOUSE EXITED

func _on_PlayBtn_mouse_exited():
	playBtnMouseHover = false

func _on_CreditsBtn_mouse_exited():
	creditsBtnMouseHover = false

func _on_ExitBtn_mouse_exited():
	exitBtnMouseHover = false
