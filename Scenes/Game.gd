extends Node

var rng = RandomNumberGenerator.new()

# should have an array of Phase objects
# each Phase has an array of key word objects
# each key word object has a name and a count

func _ready():
	rng.randomize()
	$SpeechProcessor.turn_on()

func _on_SpeechProcessor_processed_message_received(message):
	if message.length() > 0:
		$CanvasLayer/GUI.updateTranscript(message)
		
		for i in message.count("hammer"):
			generate_items("hammer")

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_SPACE:
			$SpeechProcessor.turn_off()
			$SpeechProcessor.turn_on()

func generate_items(name):
	for i in rng.randi_range(2, 5):
		var hammer_instance = load("res://Scenes/" + name.capitalize() + ".tscn").instance()
		add_child(hammer_instance)
		hammer_instance.position = $Player.position

func _on_SpawnTimer_timeout():
	var spawn_position = get_random_position_in_spawn_area()
	
	while spawn_position.distance_to($Player.position) < 64:
		spawn_position = get_random_position_in_spawn_area()

	var slime_instance = load("res://Scenes/Slime.tscn").instance()
	add_child(slime_instance)
	slime_instance.position = spawn_position
	slime_instance.set_destination(Vector2($SpawnArea.position.x, $SpawnArea.position.y))

func get_random_position_in_spawn_area():
	var rand_x = rng.randi_range(0, $SpawnArea/CollisionShape2D.get_shape().extents.x)
	var rand_y = rng.randi_range(0, $SpawnArea/CollisionShape2D.get_shape().extents.y)
	
	if randf() > 0.5:
		rand_x *= -1
	if randf() > 0.5:
		rand_y *= -1

	return Vector2($SpawnArea.position.x + rand_x, $SpawnArea.position.y + rand_y)

func _process(_delta):
	var slimes = get_tree().get_nodes_in_group("Slime")
	
	for slime in slimes:
		slime.set_destination($Player.position)
