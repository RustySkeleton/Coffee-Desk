extends Node3D

@onready var eye = $Eye
@onready var animation_player = $AnimationPlayer
@onready var timer = $Timer
@onready var whispers = $Whispers

const COME_ANIMS:Array  = ["EyeCome", "EyeCome2", "EyeCome3"]
const GO_ANIMS:Array  = ["EyeGo", "EyeGo2", "EyeGo3"]
const TOP_POSITION = Vector3(0.634,1.25,0.362)
const DEFAULT_POSITION = Vector3(-0.261,1.243,-0.223)

var i : int
var under_observation = false

func random_number():
	randomize()
	i = randi()%3	
func eye_come():
	random_number()
	if i == 2:
		eye.position = TOP_POSITION
	else:
		eye.position = DEFAULT_POSITION
	animation_player.play(COME_ANIMS[i])
	await animation_player.animation_finished
	under_observation = true
	whispers.play()
func eye_come_main_menu():
	random_number()
	if i == 2:
		eye.position = TOP_POSITION
	else:
		eye.position = DEFAULT_POSITION
	animation_player.play(COME_ANIMS[i])
	await animation_player.animation_finished
	await get_tree().create_timer(1.0).timeout
	eye_go()
	
func eye_go():
	animation_player.play(GO_ANIMS[i])
	whispers.playing = false
	under_observation = false
func start_the_timer():
	timer.start()
