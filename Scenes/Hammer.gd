extends Area2D

var rng = RandomNumberGenerator.new()

var angular_speed = 10
var speed = 200
var angle

func die():
	get_tree().queue_delete(self)

func _ready():
	rng.randomize()
	angle = rng.randf_range(0.0, 2 * PI)

func _on_Hammer_body_entered(body):
	if body.is_in_group("Slime"):
		body.die()
		die()

func _physics_process(delta):
	rotation += angular_speed * delta
	position += speed * delta * Vector2(cos(angle), sin(angle))
	
	if position.x < 0 - 200 or position.x > 640 + 200 or position.y < 0 - 200 or position.y > 480 + 200:
		die()
