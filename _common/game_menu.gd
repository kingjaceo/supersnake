class_name GameMenu
extends CanvasItem

@export var time_scale: float = 1 # pause the game when active
@export var disable_input: bool = true # disable input


func _reload():
	Engine.time_scale = 1.0
	SceneManager.reload_current_scene()


func _back_to_main():
	Engine.time_scale = 1.0
	SceneManager.to_main_menu()


func _exit_game():
	get_tree().quit()


func _toggle():
	if visible:
		visible = false
		Engine.time_scale = 1
		Global.input_disabled = false
	else:
		visible = true
		Engine.time_scale = time_scale
		Global.input_disabled = disable_input
