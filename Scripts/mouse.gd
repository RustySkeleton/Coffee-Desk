extends Node3D

@onready var mouse = $mouse_001
@onready var animation_player = $AnimationPlayer
@onready var mug = $"../Mug"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_mouse_input_event(camera, event, event_position, normal, shape_idx):
	if !mug.is_mug_picked():
		if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
			var tween := get_tree().create_tween()
			
			tween.tween_property(mouse, "scale", (Vector3.ONE*1.5), 0.1).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(mouse, "scale", (Vector3.ONE*1.42), 0.1)
			animation_player.play("Mouse")
			await get_tree().create_timer(0.1).timeout
			animation_player.pause()
