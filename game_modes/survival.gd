class_name Survival
extends Node2D

@export var snake: Snake
@export var ground_layer: TileMapLayer
@export var food_layer: TileMapLayer

## this script should handle:
# - sending the snake to the opposite side of the map when it gets too close
#   to the edge (eg, within 2 cells of the edge); wraparound/toroidal map logic
# - detecting and consuming food given the snake's location and cells of
#   food_layer, updating score on screen
# - what happens when the snake dies: 


## detect food collision:
# lookup the snake's head's position in the food tilemap:
# find the cell of the snake's head in the tilemap
# check if the cell contains food
# check if the snake's head is less than 1 radius away from the center of the cell
# if the snake picks up food: increase score, call add_chunk on snake

func _process(delta):
	var snakes_position_in_food_layer = food_layer.to_local(snake.global_position)
	var snakes_cell_in_food_layer = food_layer.local_to_map(snakes_position_in_food_layer)
	if snakes_cell_in_food_layer in food_layer.get_used_cells():
		# we know the snake is in a cell with food
		# now check the snakes position in the food layer is equal to the cell's position
		if food_layer.map_to_local(snakes_cell_in_food_layer).distance_to(snakes_position_in_food_layer) < 8:
			# snake can eat the food:
			# remove the cell from the food layer
			# feed the snake
			# update the score
			pass
