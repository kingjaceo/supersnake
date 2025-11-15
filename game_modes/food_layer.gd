class_name FoodLayer
extends TileMapLayer

@export var ground_layer: TileMapLayer
@export var time_between_spawn: float = 5.0
var time_since_food_spawn:  float = 0.0


func _process(delta):
	time_since_food_spawn += delta
	if time_since_food_spawn > time_between_spawn:
		time_since_food_spawn = 0.0
		_spawn_food()


func _spawn_food():
	var choices = ground_layer.get_used_cells()
	var filled = get_used_cells()
	var choice = choices[randi() % choices.size()]
	while choice in filled:
		choice = choices[randi() % choices.size()]
	set_cell(choice, 0, Vector2i(0, 0))


func remove_food(coords):
	set_cell(coords)
	if get_used_cells().size() == 0:
		time_since_food_spawn = time_between_spawn
