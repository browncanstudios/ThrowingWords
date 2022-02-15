extends KinematicBody2D

# the speed at which the player walks, configurable
export var speed = 200

var velocity = Vector2(0.0, 0.0)
var direction = Vector2(0.0, 1.0)

func _physics_process(_delta):
	# movement using key presses
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		velocity.x = -speed
	elif Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		velocity.x = speed
	else:
		velocity.x = 0
	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP):
		velocity.y = - speed
	elif Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN):
		velocity.y = speed
	else:
		velocity.y = 0

	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		velocity = speed * (get_global_mouse_position() - global_position).normalized()

	if !velocity.is_equal_approx(Vector2.ZERO):
		direction = velocity.normalized()

	# this function actually moves the character, and correctly
	# handles collisions with basic objects like tiles
	var returned_velocity = move_and_slide(velocity, Vector2(0, 0), false, 4, 0, false)
	
	if abs(returned_velocity.x) > abs(returned_velocity.y):
		if returned_velocity.x > 0:
			$AnimatedSprite.play("Right")
		elif returned_velocity.x < 0:
			$AnimatedSprite.play("Left")
	elif abs(returned_velocity.x) < abs(returned_velocity.y):
		if returned_velocity.y > 0:
			$AnimatedSprite.play("Down")
		elif returned_velocity.y < 0:
			$AnimatedSprite.play("Up")
	else:
		$AnimatedSprite.stop()
