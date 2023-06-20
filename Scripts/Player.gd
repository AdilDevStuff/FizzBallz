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
export (float) var crateJumpDelay = 0.4
export (float) var pickupCastLength = 100
export (float) var pickableTiltAngle = 300
var index = 0
var jumpCount = 2

# BOOLEANS
var isDead = false
var isMoving = true
var canSwitch = false
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
onready var inputPrompt = $InputPrompt
onready var cratespawnPos = $Head/CrateSpawnPos
onready var crate = preload("res://Scenes/Crate1.tscn")
onready var currentTextures = [normalBall]
onready var textures = [normalBall, beachBall, stoneBall]
onready var mainMenuUI = $"../MainMenu/MainMenuUI"
onready var pauseMenuUI = $"../PauseMenu/PauseMenuUI"

# ---------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	inputPrompt.visible = false
	pickCast.cast_to.x = pickupCastLength
	cratespawnPos.position = pickupDropPosition
	pickable.visible = false

func _process(delta):
	sprite.texture = getCurrentTexture()
	
	if isPicked:
		inputPrompt.visible = false

func _physics_process(delta):
	if !isDead and !pauseMenuUI.visible:
		movement(delta)
	if !isDead and !mainMenuUI.visible and !pauseMenuUI.visible:
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
	if !mainMenuUI.visible:
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
		pickable.rotation_degrees = lerp(pickable.rotation_degrees, deg2rad(-pickableTiltAngle), 0.2)
	elif horizontalAxis == -1:
		velocity.x = -speed
		sprite.rotation_degrees -= deg2rad(rotatingSpeed)
		isMoving = true
		pickCast.cast_to.x = -pickupCastLength
		cratespawnPos.position = -pickupDropPosition
		pickable.rotation_degrees = lerp(pickable.rotation_degrees, deg2rad(pickableTiltAngle), 0.2)
	else:
		velocity.x = lerp(velocity.x, 0, lerpFactor * delta)
		pickable.rotation_degrees = lerp(pickable.rotation_degrees, deg2rad(0), 0.2)
		isMoving = false

func jumpAnimation():
	crateScaleTween()
	cratePositionTween()
	var tween = get_tree().create_tween()
	tween.tween_property(sprite, "scale", stretchedScale, 0.1)
	tween.tween_property(sprite, "scale", defaultScale, 0.2)

func cratePositionTween():
	var tween = get_tree().create_tween()
	tween.tween_property(pickable, "position", Vector2(0,-30), 0.3)
	tween.tween_property(pickable, "position", Vector2(0,0), 0.2)

func crateScaleTween():
	var tween = get_tree().create_tween()
	tween.tween_property(pickable, "scale", Vector2(0.85,1.1), 0.12)
	tween.tween_property(pickable, "scale", Vector2(1,1), 0.12)

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
		0: # Normal Ball
			speed = 400
			gravity = 30
			rotatingSpeed = 500
			pickCast.enabled = false
		1: # Beach Ball
			speed = 500
			gravity = 20
			rotatingSpeed = 600
			pickCast.enabled = false
		2: # Stone Ball
			speed = 250
			gravity = 50
			rotatingSpeed = 300
			pickCast.enabled = true

func pickupCastCheck():
	if pickCast.is_colliding():
		var collider = pickCast.get_collider()
		if collider.is_in_group("Pickable") and index == 2:
			inputPrompt.visible = true
			if Input.is_action_just_pressed("Pickup") and index == 2 and !isPicked and !canDrop:
				isPicked = true
				canDrop = true
				# Tween Crate To 0
				var tween = get_tree().create_tween()
				tween.tween_property(collider,"scale", Vector2(0,0), 0.07)
				# Tween Crate Sprite To 1
				var spriteTween = get_tree().create_tween()
				pickable.scale = Vector2.ZERO
				spriteTween.tween_property(pickable, "scale", Vector2(1,1), 0.07)
				pickable.visible = true
				yield(tween, "finished")
				# Delete Crate Instance / Picked Crate
				collider.queue_free()
	else:
		inputPrompt.visible = false

func dropPickable():
	if isPicked and canDrop and index == 2:
		if Input.is_action_just_pressed("Drop"):
			spawnPickable()
	elif isPicked and index == 0 or index == 1 and isPicked:
		spawnPickable()

func spawnPickable():
	if !pickCast.is_colliding():
		var newCrateInstance = crate.instance()
		var instanceTween = get_tree().create_tween()
		newCrateInstance.global_position = cratespawnPos.global_position
		newCrateInstance.global_scale = Vector2.ZERO
		get_parent().add_child(newCrateInstance)
		instanceTween.tween_property(newCrateInstance, "scale", Vector2(1,1), 0.07)
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
		SceneTransition.reloadScene()

func _on_PlayerAnims_animation_finished(anim_name):
	if anim_name == "Death":
		get_tree().reload_current_scene()
