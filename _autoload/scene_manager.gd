extends Node

var current_scene: PackedScene
var current_scene_instance

var main_menu: PackedScene = load("res://_common/start_screen.tscn")
var credit_screen: PackedScene = load("res://_common/credit_screen.tscn")
var game_modes: Array[PackedScene] = [load("res://game_modes/survival.tscn")]


func transition_to(scene: PackedScene):
	await _load_scene(scene)


func reload_current_scene():
	_load_scene(current_scene)


func _load_scene(scene:PackedScene) -> void:
	current_scene = scene
	get_tree().change_scene_to_packed(scene)


## specific transitions ##
func to_main_menu():
	transition_to(main_menu)


func load_game_mode(i: int):
	transition_to(game_modes[i])


func load_credit_screen():
	transition_to(credit_screen)
