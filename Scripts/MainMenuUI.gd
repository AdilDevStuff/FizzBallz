extends Control

# ---------- VARIABLES ---------- #

# NORMAL
export (float) var tweenDuration
export (Color) var zeroOpacity

# BOOLEANS


# VECTOR


# ONREADY
onready var menuBtns = $MenuBtns
onready var playBtn = $MenuBtns/PlayBtn
onready var creditsBtn = $MenuBtns/CreditsBtn
onready var exitBtn = $MenuBtns/ExitBtn
onready var blur = $Blur
onready var bg = $BG


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

func menuExitAnimation():
	var tween = get_tree().create_tween()
	tween.tween_property(menuBtns, "rect_scale", Vector2(0,0), tweenDuration).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(blur, "self_modulate", zeroOpacity, tweenDuration).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(bg, "self_modulate", zeroOpacity, tweenDuration).set_trans(Tween.TRANS_CUBIC)
	yield(tween, "finished")
	self.visible = false

func btnByBtnMenuExitAnimation():
	var tween = get_tree().create_tween()
	tween.tween_property(playBtn, "rect_scale", Vector2(0,0), tweenDuration).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(creditsBtn, "rect_scale", Vector2(0,0), tweenDuration).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(exitBtn, "rect_scale", Vector2(0,0), tweenDuration).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(blur, "self_modulate", zeroOpacity, tweenDuration).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(bg, "self_modulate", zeroOpacity, tweenDuration).set_trans(Tween.TRANS_CUBIC)
	yield(tween, "finished")
	self.visible = false
# ---------- SIGNALS ---------- #


func _on_PlayBtn_pressed():
	btnByBtnMenuExitAnimation()

func _on_CreditsBtn_pressed():
	btnByBtnMenuExitAnimation()

func _on_ExitBtn_pressed():
	get_tree().quit()
