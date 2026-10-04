extends Node3D
@onready var coffee_cup = $"Hand/Coffee Cup"
@onready var animation_player = $Hand/AnimationPlayer
@onready var area_3d = $"Hand/Coffee Cup/Area3D"
@export var monitor: Node3D
@export var sip_timer: Timer
var i = 1
var mug_picked:bool = false
var sip:bool = false
var sip_position
@onready var place = $Place
@onready var sipping = $Sip
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_mug_input_event(camera, event, event_position, normal, shape_idx):
	if !Global.tutorial:
		if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT) and !mug_picked:
			var tween := get_tree().create_tween()
			area_3d.disable_mode=true
			tween.tween_property(coffee_cup, "scale", (Vector3.ONE*1.05), 0.1).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(coffee_cup, "scale", (Vector3.ONE), 0.1)
			animation_player.play("Coffee_Pickup")
			place.play()
func _unhandled_input(event):
	if !Global.tutorial:
		if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT) and mug_picked:
			animation_player.play("Coffee_Keep")
		

func _process(delta):
	if Input.is_action_pressed("Left Click") and mug_picked and !sip:
		sip = true
		animation_player.play("Coffee_Sip")
		sipping.play()
		if sip_timer:
			sip_timer.start()
	if Input.is_action_just_released("Left Click") and mug_picked:
		sip = false
		animation_player.play_section("Coffee_Sip_Stop", 1.0 - animation_player.current_animation_position)

	
	
func is_mug_picked()->bool:
	return mug_picked


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Coffee_Pickup":
		mug_picked = true
	elif anim_name == "Coffee_Keep":
		place.play()
		mug_picked = false
