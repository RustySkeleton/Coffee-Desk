extends Node3D
@onready var keyboard_001 = $keyboard_001
@onready var animation_player = $AnimationPlayer
@onready var mug = $"../Mug"
@onready var monitor = $"../Monitor"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_keyboard_input_event(camera, event, event_position, normal, shape_idx):
	if !mug.is_mug_picked():
		if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
			var tween := get_tree().create_tween()
			
			tween.tween_property(keyboard_001, "scale", (Vector3.ONE*1.43), 0.1).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(keyboard_001, "scale", (Vector3.ONE*1.42), 0.1)
			animation_player.play("Cube_001Action")
			monitor.scroll()
			await get_tree().create_timer(0.1).timeout
			animation_player.pause()
			monitor.stop_scroll()
