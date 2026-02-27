extends CharacterBody2D

@export var gravity = 600.0
@export var walk_speed = 200
@export var crouch_speed = 100
@export var jump_speed = -300

@export var dash_speed = 600
@export var dash_duration = 0.2
var is_dashing = false

var double_tap_window = 0.25
var right_tap_timer = 0.0
var left_tap_timer = 0.0

var max_jumps = 2
var jump_count = 0
var is_crouching = false

@onready var anim = $AnimatedSprite2D


func _physics_process(delta):
	if right_tap_timer > 0:
		right_tap_timer -= delta
	if left_tap_timer > 0:
		left_tap_timer -= delta

	if not is_on_floor() and not is_dashing:
		velocity.y += delta * gravity
	elif is_on_floor():
		jump_count = 0

	# Crouching
	if is_on_floor() and Input.is_action_pressed("ui_down"):
		is_crouching = true
	else:
		is_crouching = false

	# Jump
	if Input.is_action_just_pressed("ui_up") and jump_count < max_jumps and not is_crouching:
		velocity.y = jump_speed
		jump_count += 1

	if not is_dashing:
		var current_speed = crouch_speed if is_crouching else walk_speed

		if Input.is_action_pressed("ui_right"):
			velocity.x = current_speed
			anim.flip_h = false
		elif Input.is_action_pressed("ui_left"):
			velocity.x = -current_speed
			anim.flip_h = true
		else:
			velocity.x = 0

		if Input.is_action_just_pressed("ui_right"):
			if right_tap_timer > 0:
				start_dash(1)
			else:
				right_tap_timer = double_tap_window

		elif Input.is_action_just_pressed("ui_left"):
			if left_tap_timer > 0:
				start_dash(-1)
			else:
				left_tap_timer = double_tap_window

	move_and_slide()
	update_animations()


func start_dash(direction_multiplier):
	is_dashing = true

	velocity.x = dash_speed * direction_multiplier
	velocity.y = 0

	await get_tree().create_timer(dash_duration).timeout

	is_dashing = false


func update_animations():
	if not is_on_floor():
		if velocity.y < 0:
			anim.play("jump")
		else:
			anim.play("fall")
	else:
		if velocity.x != 0:
			anim.play("walk")
		else:
			if is_crouching:
				anim.play("crouch")
			else:
				anim.play("idle")
