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
# - what happens when the snake dies
