extends Node3D

@onready var camera_3d = $Camera3D
@onready var clock = $Clock
@onready var monitor = $Monitor
@onready var mouse = $Mouse
@onready var mug = $Mug
@onready var keyboard = $Keyboard
@onready var eye_2 = $Eye2
@onready var footsteps = $Footsteps
@onready var stinger = $Stinger
@onready var spot_light_3d = $SpotLight3D
@onready var scripts = $Scripts
@onready var scripts_2 = $Scripts2
@onready var scripts_3 = $Scripts3
@onready var canvas_layer_2 = $CanvasLayer2
@onready var health_bar = $CanvasLayer/HealthBar
@onready var work_bar = $CanvasLayer/WorkBar
@onready var clap = $Clap
@onready var scripts_4 = $Scripts4
@export var alottaeyes: PackedScene


signal gameover
signal asleep

var time = 0
var timer_start = false
var under_observation = false
var over = false
var eyes_added = false
@export var appearance : Array[int]

func _ready():
	
	new_game()


func new_game():
	time = 0
	eyes_added = false
	spot_light_3d.light_color= "#d4ffe8"
	under_observation = false
	timer_start = false
	monitor.slacking = false
	mug.mug_picked = false
	keyboard.audio.stream_paused = true
	eye_2.eye_come()
	await get_tree().create_timer(2.0).timeout
	scripts.visible = true
	Global.tutorial = true
	scripts.read()
	eye_2.start_the_timer()
	await eye_2.timer.timeout
	Global.tutorial = false
	timer_start = true

func game_over():
	if !eyes_added:
		timer_start = false
		stinger.play()
		spot_light_3d.light_color= "red"
		
		Global.tutorial = true
		scripts_3.visible = true
		scripts_3.read()
		var eyes = alottaeyes.instantiate()
		add_child(eyes)
		eyes_added = true
		clock.tick.playing = false
		#get_tree().paused = true
		await get_tree().create_timer(5.0).timeout
		#get_tree().paused = false
		get_tree().change_scene_to_file("res://Scenes/mainmenu.tscn")
func game_win():
	timer_start = false
	clap.play()
	spot_light_3d.light_color= "#00b7ea"
	Global.tutorial = true
	scripts_4.visible = true
	scripts_4.read()
	clock.tick.playing = false
	#get_tree().paused = true
	await get_tree().create_timer(10.0).timeout
	#get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/mainmenu.tscn")

func _process(delta):
	if not over:
		if timer_start and time<360:
			time=clamp(time+(delta), 0, 360)
			clock.update_clock(time)
		under_observation = eye_2.under_observation
		if time+10 in appearance:
			footsteps.play()
			footsteps.volume_db=10.0
		elif time in appearance:
			footsteps.stream_paused = true
			eye_2.eye_come()
			await eye_2.animation_player.animation_finished
			eye_2.start_the_timer()
		if under_observation and monitor.slacking:
			over = true
			gameover.emit()
			game_over()
		#if under_observation and not monitor.slacking:
			#scripts_2.visible = true
			#scripts_2.read()
		if Global.current_health<=0:
			canvas_layer_2.visible = true
			canvas_layer_2.fade_out()
			eye_2.eye_come()
			await get_tree().create_timer(4.0).timeout
			canvas_layer_2.fade_in()
			canvas_layer_2.visible = false
			over = true
			gameover.emit()
			game_over()
		if time >= 360 :
			if Global.current_work < Global.max_work:
				canvas_layer_2.visible = true
				canvas_layer_2.fade_out()
				eye_2.eye_come()
				await get_tree().create_timer(2.0).timeout
				canvas_layer_2.fade_in()
				canvas_layer_2.visible = false
				gameover.emit()
				over = true
				game_over()
			else:
				canvas_layer_2.visible = true
				canvas_layer_2.fade_out()
				eye_2.eye_come()
				await get_tree().create_timer(2.0).timeout
				canvas_layer_2.fade_in()
				canvas_layer_2.visible = false
				gameover.emit()
				over = true
				game_win()
func _on_sip_timer_timeout():
	Global.current_health = clamp(Global.current_health + randi_range(Global.health_gain-2,Global.health_gain) * Global.health_multiplier, 0.0, Global.max_health)
	health_bar.update()


func _on_awake_timer_timeout():
	if timer_start and time<360:
		Global.current_health = clamp(Global.current_health - randi_range(Global.health_gain, Global.health_gain+2),0, Global.max_health)
		health_bar.update()
