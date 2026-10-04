extends ProgressBar


func _ready():
	update()


func update():
	value = Global.current_work*100/Global.max_work
