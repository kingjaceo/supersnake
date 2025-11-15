class_name Survival
extends Node2D

@export var snake: Snake
@export var safe_time: float = 5.0
@export var ground_layer: TileMapLayer
@export var food_layer: FoodLayer
var score: int = 0

## this script should handle:
# - sending the snake to the opposite side of the map when it gets too close
#   to the edge (eg, within 2 cells of the edge); wraparound/toroidal map logic

func _ready():
	await get_tree().create_timer(safe_time).timeout
	snake.self_collision.connect(_game_over)


func _process(delta):
	var snakes_position_in_food_layer = food_layer.to_local(snake.global_position)
	var snakes_cell_in_food_layer = food_layer.local_to_map(snakes_position_in_food_layer)
	if snakes_cell_in_food_layer in food_layer.get_used_cells(): # the snake is in a cell with food
		if food_layer.map_to_local(snakes_cell_in_food_layer).distance_to(snakes_position_in_food_layer) < 8:
			food_layer.remove_food(snakes_cell_in_food_layer)
			snake.add_chunk()
			_update_score()
			
	var snakes_position_in_ground_layer = ground_layer.to_local(snake.global_position)
	var snakes_cell_in_ground_layer = ground_layer.local_to_map(snakes_position_in_ground_layer)
	var new_x = snake.global_position.x
	var new_y = snake.global_position.y
	if snakes_cell_in_food_layer.x < 0:
		new_x += ground_layer.map_to_local(ground_layer.get_used_rect().size).x
	if snakes_cell_in_food_layer.y < 0:
		new_y += ground_layer.map_to_local(ground_layer.get_used_rect().size).y
	if snakes_cell_in_food_layer.x > ground_layer.get_used_rect().size.x:
		new_x -= ground_layer.map_to_local(ground_layer.get_used_rect().size).x
	if snakes_cell_in_food_layer.y > ground_layer.get_used_rect().size.y:
		new_y -= ground_layer.map_to_local(ground_layer.get_used_rect().size).y
	snake.teleport(Vector2(new_x, new_y))


func _update_score():
	score += 1


func _game_over():
	Engine.time_scale = 0.0
	$Menus/GameOverScreen.visible = true
	
