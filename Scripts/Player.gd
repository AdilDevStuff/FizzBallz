extends KinematicBody2D

# ---------- VARIABLES ---------- #

# NORMAL
export (float) var speed
export (float) var gravity
export (float) var jumpForce
export (float) var rotatingSpeed
export (float) var lerpFactor
var jumpCount = 2


# BOOLEANS
var isMoving = true

# VECTOR
export (Vector2) var defaultScale
export (Vector2) var stretchedScale
var velocity := Vector2.ZERO
var direction = Vector2.ZERO

# ONREADY
onready var playerAnims = $PlayerAnims
onready var sprite = $Sprite

# ---------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	movement(delta)

# ---------- CUSTOM FUNCTIONS ---------- #

func movement(delta):
	if !is_on_floor():
		velocity.y += gravity
	else:
		jumpCount = 2

	if Input.is_action_just_pressed("Jump") and jumpCount > 0:
		jumpAnimation()
		velocity.y = -jumpForce
		jumpCount -= 1
	
	var horizontalAxis = Input.get_axis("Left", "Right")
	getInput(horizontalAxis, delta)
	
	velocity = move_and_slide(velocity, Vector2.UP)

func getInput(horizontalAxis: float, delta):
	if horizontalAxis == 1:
		velocity.x = speed
		sprite.rotation_degrees += deg2rad(rotatingSpeed)
		isMoving = true
	elif horizontalAxis == -1:
		velocity.x = -speed
		sprite.rotation_degrees -= deg2rad(rotatingSpeed)
		isMoving = true
	else:
		velocity.x = lerp(velocity.x, 0, lerpFactor * delta)
		isMoving = false


func jumpAnimation():
	var tween = get_tree().create_tween()
	tween.tween_property(sprite, "scale", stretchedScale, 0.1)
	tween.tween_property(sprite, "scale", defaultScale, 0.2)

# ---------- SIGNALS ---------- #
