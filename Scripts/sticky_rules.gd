extends Node3D

@onready var mug = $"../Mug"
@export var sticky_note : MeshInstance3D
@export var animation_player : AnimationPlayer
@export var animation : String
var note_picked = false

func _on_note_rule_input_event(camera, event, event_position, normal, shape_idx):
	if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT) and !mug.mug_picked and !note_picked:
		var tween := get_tree().create_tween()
		tween.tween_property(sticky_note, "scale", (Vector3.ONE*1.05), 0.1).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(sticky_note, "scale", (Vector3.ONE), 0.1)
		animation_player.play(animation)
		await animation_player.animation_finished
		note_picked = true
	elif (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT) and !mug.mug_picked and note_picked:
		var tween := get_tree().create_tween()
		tween.tween_property(sticky_note, "scale", (Vector3.ONE*1.05), 0.1).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(sticky_note, "scale", (Vector3.ONE), 0.1)
		animation_player.play_backwards(animation)
		note_picked = false
