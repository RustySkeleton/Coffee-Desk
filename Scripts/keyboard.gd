extends Node3D
@onready var keyboard_001 = $keyboard_001
@onready var animation_player = $AnimationPlayer
@onready var mug = $"../Mug"
@onready var monitor = $"../Monitor"
@onready var audio = $AudioStreamPlayer3D
@onready var health_bar = $"../CanvasLayer/HealthBar"
@onready var work_bar = $"../CanvasLayer/WorkBar"


# Called when the node enters the scene tree for the first time.
func _ready():
	audio.stream_paused = true


func _on_keyboard_input_event(camera, event, event_position, normal, shape_idx):
	if !Global.tutorial:
		if !mug.is_mug_picked():
			if !monitor.slacking:
				if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
					var tween := get_tree().create_tween()
					
					tween.tween_property(keyboard_001, "scale", (Vector3.ONE*1.43), 0.1).set_trans(Tween.TRANS_CUBIC)
					tween.tween_property(keyboard_001, "scale", (Vector3.ONE*1.42), 0.1)
					animation_player.play("Cube_001Action")
					audio.stream_paused = false
					audio.volume_db = 0.0
					monitor.scroll()
					Global.current_work+=0.2
					work_bar.update()
					Global.current_health-=10
					health_bar.update()
					await get_tree().create_timer(0.1).timeout
					animation_player.pause()
					audio.stream_paused = true
					monitor.stop_scroll()
				else:
					audio.stream_paused = true
