extends CanvasLayer
@export var main_menu: Node3D


func _on_play_button_pressed():
	main_menu.new_game()

func _on_quit_button_pressed():
	get_tree().quit()
