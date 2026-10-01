extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	value = Global.current_health*100/Global.max_health
