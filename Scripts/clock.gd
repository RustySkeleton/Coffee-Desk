extends Node3D
@onready var label = $SubViewport/Label
@onready var tick = $tick
var clock_time = 0
@export var main: Node3D

func _process(delta):
	if !main.over:
		if clock_time>0:
			if !tick.playing:
				tick.volume_db = -25.0
				tick.play()


func update_clock(time):
	clock_time = time
	var hour = int(time)/60
	var minute = int(time)%60
	label.text = str("0",hour,":",minute) if minute>9 else str("0", hour, ":0", minute )
	
