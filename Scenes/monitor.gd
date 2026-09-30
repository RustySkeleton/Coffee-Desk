extends Node3D
@onready var video = $SubViewport/VideoStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func scroll():
	video.paused = false

func stop_scroll():
	video.paused = true
