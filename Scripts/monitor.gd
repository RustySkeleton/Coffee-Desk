extends Node3D
@onready var video = $SubViewport/VideoStreamPlayer

var slacking = false
const CODING = "res://Assets/Monitor/output.ogv"
const SLACK = "res://Assets/Monitor/Cats_Multiple.ogv"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func switch():
	slacking = !slacking
	if slacking:
		video.stream = load(SLACK)
		video.speed_scale = 3.0
		video.volume_db = -20
		video.paused = false
		video.play()
	else:
		video.stream = load(CODING)
		video.speed_scale = 10.0
		video.play()
		await get_tree().create_timer(0.1).timeout
		video.paused = true

func scroll():
	video.paused = false

func stop_scroll():
	video.paused = true
