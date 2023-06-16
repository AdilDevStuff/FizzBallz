extends KinematicBody2D

# ---------- VARIABLES ---------- #

# NORMAL
export (Texture) var normalBall
export (Texture) var beachBall
export (Texture) var stoneBall

export (float) var speed = 600
export (float) var gravity = 30
export (float) var jumpForce = 700
export (float) var lerpFactor = 10
export (float) var rotatingSpeed = 500
export (float) var pickupCastLength = 100
var index = 0
var jumpCount = 2

# BOOLEANS
var isDead = false
var isMoving = true
var canSwitch = true
var canDrop = false
var isPicked = false
var isNearPickable = false

# VECTOR
export (Vector2) var defaultScale = Vector2(0.6, 0.6)
export (Vector2) var stretchedScale = Vector2(0.4, 0.75)
export (Vector2) var pickupDropPosition = Vector2(90,0)
var velocity := Vector2.ZERO
var direction := Vector2.ZERO

# ONREADY
onready var head = $Head
onready var sprite = $Sprite
onready var pickCast = $PickCast
onready var pickable = $Head/Pickable
onready var playerAnims = $PlayerAnims
onready var pickupInfoLabel = $PickupInfo
onready var cratespawnPos = $Head/CrateSpawnPos
onready var crate = preload("res://Scenes/Crate1.tscn")
onready var textures = [normalBall, beachBall, stoneBall]

# ---------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	pickupInfoLabel.visible = false
	pickCast.cast_to.x = pickupCastLength
	cratespawnPos.position = pickupDropPosition
	head.get_node("Pickable").visible = false

func _process(delta):
	sprite.texture = getCurrentTexture()

func _physics_process(delta):
	if !isDead:
		movement(delta)
		characterSwitch()
		characterAbilities()
		pickupCastCheck()
		dropPickable()

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
		pickCast.cast_to.x = pickupCastLength
		cratespawnPos.position = pickupDropPosition
	elif horizontalAxis == -1:
		velocity.x = -speed
		sprite.rotation_degrees -= deg2rad(rotatingSpeed)
		isMoving = true
		pickCast.cast_to.x = -pickupCastLength
		cratespawnPos.position = -pickupDropPosition
	else:
		velocity.x = lerp(velocity.x, 0, lerpFactor * delta)
		isMoving = false

func jumpAnimation():
	var tween = get_tree().create_tween()
	tween.tween_property(sprite, "scale", stretchedScale, 0.1)
	tween.tween_property(sprite, "scale", defaultScale, 0.2)

func switchAnimation():
	var tween = get_tree().create_tween()
	tween.tween_property(sprite, "scale", Vector2(0.65,0.65), 0.1)
	tween.tween_property(sprite, "scale", Vector2(0,0), 0.1)
	tween.tween_property(sprite, "scale", defaultScale, 0.1)
	yield (tween, "step_finished")
	scrollToNextTexture()

func characterSwitch():
	if canSwitch:
		if Input.is_action_just_pressed("Switch"):
			switchAnimation()

func characterAbilities():
	match index:
		0:
			speed = 400
			gravity = 30
			rotatingSpeed = 500
			pickCast.enabled = false
		1:
			speed = 500
			gravity = 20
			rotatingSpeed = 600
			pickCast.enabled = false
		2:
			speed = 250
			gravity = 50
			rotatingSpeed = 300
			pickCast.enabled = true

func pickupCastCheck():
	if pickCast.is_colliding():
		var collider = pickCast.get_collider()
		if collider.is_in_group("Pickable") and index == 2:
			pickupInfoLabel.visible = true
			if Input.is_action_just_pressed("Pickup") and index == 2 and !isPicked:
				isPicked = true
				canDrop = true
				# Tween Crate To 0
				var tween = get_tree().create_tween()
				tween.tween_property(collider,"scale", Vector2(0,0), 0.05)
				# Tween Crate Sprite To 1
				var spriteTween = get_tree().create_tween()
				pickable.scale = Vector2.ZERO
				spriteTween.tween_property(pickable, "scale", Vector2(1,1), 0.05)
				pickable.visible = true
				yield(tween, "finished")
				# Delete Crate Instance / Picked Crate
				collider.queue_free()
	else:
		pickupInfoLabel.visible = false

func dropPickable():
	if isPicked and canDrop and index == 2:
		if Input.is_action_just_pressed("Drop"):
			spawnPickable()
	elif isPicked and index == 0 or index == 1 and isPicked:
		spawnPickable()

func spawnPickable():
	var newCrateInstance = crate.instance()
	newCrateInstance.global_position = cratespawnPos.global_position
	get_parent().add_child(newCrateInstance)
	canDrop = false
	isPicked = false
	pickable.visible = false
	pickCast.enabled = true

func scrollToNextTexture():
	index = posmod(index + 1, textures.size())

func getCurrentTexture():
	return textures[index]

# ---------- SIGNALS ---------- #

func _on_Collision_body_entered(body):
	if body.is_in_group("Traps") and index != 2:
		isDead = true
		playerAnims.play("Death")

func _on_PlayerAnims_animation_finished(anim_name):
	if anim_name == "Death":
		get_tree().reload_current_scene()
