extends CanvasLayer
@onready var color_rect = $ColorRect

func fade_out():
	var tween := get_tree().create_tween()
	tween.tween_property(color_rect, "color", Color(0,0,0,1), 1.0)
	
func fade_in():
	var tween := get_tree().create_tween()
	tween.tween_property(color_rect, "color", Color(0,0,0,0), 1.0)
	
