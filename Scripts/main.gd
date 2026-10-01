extends Node3D

@onready var camera_3d = $Camera3D
@onready var clock = $Clock
@onready var monitor = $Monitor
@onready var mouse = $Mouse
@onready var mug = $Mug
@onready var keyboard = $Keyboard
@onready var eye_2 = $Eye2
@onready var scripts = $Scripts
@onready var footsteps = $Footsteps
@onready var stinger = $Stinger
@onready var spot_light_3d = $SpotLight3D
@onready var scripts_2 = $Scripts2



var time = 0
var timer_start = false
var under_observation = false
@export var appearance : Array[int]

func _ready():
	
	new_game()
	
func new_game():
	time = 0
	spot_light_3d.light_color= "#d4ffe8"
	under_observation = false
	timer_start = false
	monitor.slacking = false
	mug.mug_picked = false
	keyboard.audio.stream_paused = true
	eye_2.eye_come()
	await get_tree().create_timer(1.5).timeout
	scripts.visible = true
	Global.tutorial = true
	scripts.read()
	eye_2.start_the_timer()
	await eye_2.timer.timeout
	Global.tutorial = false
	timer_start = true

func game_over():
	stinger.play()
	spot_light_3d.light_color= "red"
	get_tree().paused = true
	await get_tree().create_timer(10.0).timeout
	new_game()

func _process(delta):
	if timer_start:
		time+=delta
		clock.update_clock(time)
	under_observation = eye_2.under_observation
	if time+10 in appearance:
		footsteps.play()
	elif time in appearance:
		footsteps.stream_paused = true
		eye_2.eye_come()
		scripts_2.visible = true
		scripts_2.read()
		eye_2.start_the_timer()
	if under_observation and monitor.slacking:
		game_over()
	if Global.current_health<=0:
		game_over()
