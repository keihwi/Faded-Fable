extends CharacterBody2D

var speed = 130.0
const JUMP_VELOCITY = -330.0
const DASH_VELOCITY = 150.0
const DASH_DURATION = 0.3  

@onready var dash_timer: Timer = $DashTimer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var can_dash_timer: Timer = $canDashTimer

var can_dash = true
var is_dashing = false
# Current DASH mechanic allows the player to almost float for a few seconds if you press space right before dash, keep in maybe?

func _physics_process(delta: float) -> void:
	# Add gravity (only if not dashing)
	if not is_on_floor() and not is_dashing:
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_pressed("jump") and is_on_floor(): #and not is_dashing:
		velocity.y = JUMP_VELOCITY
	
	#for future crouching through platforms
	#if Input.is_action_pressed("crouch"):
		#set_collision_mask_value(5, false)
	#else:
		#set_collision_mask_value(5, true)

	var direction := Input.get_axis("move_left", "move_right")

	# Handle dash
	if Input.is_action_just_pressed("sprint") and can_dash:
		is_dashing = true
		can_dash = false
		dash_timer.start(DASH_DURATION)
		speed = 530.0

		# Launch in facing direction
		if animated_sprite.flip_h:
			velocity.x = -DASH_VELOCITY/DASH_DURATION
		else:
			velocity.x = DASH_VELOCITY/DASH_DURATION

		animated_sprite.play("dash")

	# Normal movement
	elif not is_dashing:
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)

	# Flip the sprite
	if not is_dashing:
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true

	# Handle the animations
	if not is_dashing:
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
		else:
			animated_sprite.play("jump")

	move_and_slide()


func _on_dash_timer_timeout() -> void:
	is_dashing = false
	speed = 130.0
	can_dash_timer.start()


func _on_can_dash_timer_timeout() -> void:
	can_dash = true
