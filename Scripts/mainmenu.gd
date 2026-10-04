extends Node3D

@onready var camera_3d = $Camera3D
@onready var clock = $Clock
@onready var monitor = $Monitor
@onready var mouse = $Mouse
@onready var mug = $Mug
@onready var keyboard = $Keyboard
@onready var eye_2 = $Eye2
@onready var spot_light_3d = $SpotLight3D

var over = false


var time = 0
var timer_start = false
var under_observation = false
@export var appearance : Array[int]

func _ready():
	Global.tutorial = true
	Global.current_health = 100
	Global.max_health = 100
	Global.current_work = 0
	Global.max_work = 100
	spot_light_3d.light_color= "#d4ffe8"
	under_observation = false
	timer_start = false
	monitor.slacking = false
	mug.mug_picked = false
	keyboard.audio.stream_paused = true
	eye()
	
func new_game():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	
func eye():
	eye_2.eye_come_main_menu()



func _on_timer_timeout():
	eye()
