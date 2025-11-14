class_name Snake
extends Node2D
## Code assistance from Claude AI

@export var speed: float = 30.0
@export var acceleration: float = 20.0
@export var min_speed: float = 30.0
@export var max_speed: float = 100.0

@export var turn_speed: float = 1.0
@export var turn_acceleration: float = 2.0
@export var min_turn_speed: float = 1.0
@export var max_turn_speed: float = 6.0

@export var chunk_spacing: float = 10.0

var chunks: Array[Node2D] = [] 
var position_history: Array[Dictionary] = []

func _ready():
	for child in get_children():
		if child.name.begins_with("Chunk"):
			chunks.append(child)


func _process(delta):
	# move forward: use delta and (current) speed
	var input_dir = Input.get_axis("ui_left", "ui_right")
	rotation += input_dir * turn_speed * delta
	
	var speed_input = Input.get_axis("ui_down", "ui_up")
	speed = clamp(speed + speed_input * acceleration * delta, min_speed, max_speed)
	turn_speed = clamp(turn_speed + speed_input * turn_acceleration * delta, min_turn_speed, max_turn_speed)
	
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
	
	position_history.push_front({
		"pos": position,
		"rot": rotation
	})
	
	_update_chunks()
	
	## check collisions
	#   for every chunk below Chunk 2:
	#     check if its distance from Chunk 1's position is less than twice the radius


func _update_chunks():
	for i in range(chunks.size()):
		var target_distance = chunk_spacing * (i + 1)
		var accumulated_distance = 0.0
		
		# Find the position in history at the right distance
		for j in range(position_history.size() - 1):
			var segment_length = position_history[j].pos.distance_to(position_history[j + 1].pos)
			if accumulated_distance + segment_length >= target_distance:
				# Interpolate between these two points
				var remaining = target_distance - accumulated_distance
				var t = remaining / segment_length
				var global_pos = position_history[j].pos.lerp(position_history[j + 1].pos, t)
				var global_rot = lerp_angle(position_history[j].rot, position_history[j + 1].rot, t)

				chunks[i].position = to_local(global_pos)
				chunks[i].rotation = global_rot - rotation
				break
			accumulated_distance += segment_length
	
	var max_distance = chunk_spacing * chunks.size() * 2
	while position_history.size() > 2 && get_history_length() > max_distance:
		position_history.pop_back()


func get_history_length() -> float:
	var total = 0.0
	for i in range(position_history.size() - 1):
		total += position_history[i].pos.distance_to(position_history[i + 1].pos)
	return total
