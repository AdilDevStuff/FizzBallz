extends VBoxContainer

# ---------- VARIABLES ---------- #

# NORMAL
export (float) var duration
export (float) var marginRight
export (float) var marginRightDefault

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
	playBtnHover(delta)
	creditsBtnHover(delta)
	exitBtnHover(delta)

func _physics_process(delta):
	pass

func _input(event):
	pass

# ---------- CUSTOM FUNCTIONS ---------- #

func playBtnHover(delta):
	if playBtnMouseHover:
		playBtn.margin_right = lerp(playBtn.margin_right, marginRight, duration * delta)
	else:
		playBtn.margin_right = lerp(playBtn.margin_right, marginRightDefault, duration * delta)

func creditsBtnHover(delta):
	if creditsBtnMouseHover:
		creditsBtn.margin_right = lerp(creditsBtn.margin_right, marginRight, duration * delta)
	else:
		creditsBtn.margin_right = lerp(creditsBtn.margin_right, marginRightDefault, duration * delta)

func exitBtnHover(delta):
	if exitBtnMouseHover:
		exitBtn.margin_right = lerp(exitBtn.margin_right, marginRight, duration * delta)
	else:
		exitBtn.margin_right = lerp(exitBtn.margin_right, marginRightDefault, duration * delta)

# ---------- SIGNALS ---------- #

# MOUSE ENTERED
func _on_PlayBtn_mouse_entered():
	SoundManager.UIHoverSFX.play()
	playBtnMouseHover = true

func _on_CreditsBtn_mouse_entered():
	SoundManager.UIHoverSFX.play()
	creditsBtnMouseHover = true

func _on_ExitBtn_mouse_entered():
	SoundManager.UIHoverSFX.play()
	exitBtnMouseHover = true

# MOUSE EXITED

func _on_PlayBtn_mouse_exited():
	playBtnMouseHover = false

func _on_CreditsBtn_mouse_exited():
	creditsBtnMouseHover = false

func _on_ExitBtn_mouse_exited():
	exitBtnMouseHover = false
