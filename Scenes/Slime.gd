extends RigidBody2D

var factor = 50
var destination = null

func die():
	get_tree().queue_delete(self)

func set_destination(pos):
	destination = pos

func _physics_process(delta):
	if destination != null:
		apply_central_impulse((destination - position).normalized() * factor * delta)

	if abs(linear_velocity.x) > abs(linear_velocity.y):
		if linear_velocity.x > 0:
			$AnimatedSprite.play("Right")
		elif linear_velocity.x < 0:
			$AnimatedSprite.play("Left")
	elif abs(linear_velocity.x) < abs(linear_velocity.y):
		if linear_velocity.y > 0:
			$AnimatedSprite.play("Down")
		elif linear_velocity.y < 0:
			$AnimatedSprite.play("Up")
