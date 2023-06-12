extends KinematicBody2D

# ---------- VARIABLES ---------- #

# NORMAL
export (float) var speed = 300
export (float) var gravity = 30
export (float) var jumpForce = 500
var jumpCount = 2

export (float) var health = 5

export (float) var followDistance = 400
export (float) var retreatDistance = 300


# BOOLEANS


# VECTOR
var velocity := Vector2.ZERO

# ONREADY
onready var player = get_tree().get_root().get_child(0).find_node("Player")
onready var obstacleCheck = $ObstacleCheck
onready var hand = $Hand
onready var enemyRangeArea = $EnemyRange

# ---------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	movement()
	obstacleCollisionCheck()
	flipGun(hand.get_node("Gun"))

# ---------- CUSTOM FUNCTIONS ---------- #

func jump():
	velocity.y = -jumpForce
	jumpAnimation()

func movement():
	hand.look_at(player.global_position)
	velocity.y = 0 if is_on_floor() else velocity.y + gravity
	
	var direction = position.direction_to(player.global_position)
	followDistance(direction)
	
	move_and_slide(velocity, Vector2.UP)
	
	obstacleCheck.cast_to = Vector2(-50,0) if velocity.x <= 0 else Vector2(50,0)
	enemyRangeArea.rotation_degrees = 180 if velocity.x <= 0 else 0
	
func shooting():
	pass

func followDistance(direction: Vector2):
	var distance = global_position.distance_to(player.global_position)
	
	if distance > followDistance:
		velocity.x = direction.x * speed
	elif distance < retreatDistance:
		velocity.x = -direction.x * speed
	else:
		velocity.x = 0

func obstacleCollisionCheck():
	if obstacleCheck.is_colliding():
		var collider = obstacleCheck.get_collider()
		if collider.is_in_group("Ground") or collider.is_in_group("Enemy"):
			jump()

func flipGun(gunSprite: Sprite):
	gunSprite.flip_v = true if global_position > player.global_position else false

func jumpAnimation():
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite, "scale", Vector2(0.1, 0.15), 0.1)
	tween.tween_property($Sprite, "scale", Vector2(0.13, 0.13), 0.2)

# ---------- SIGNALS ---------- #
