extends CanvasLayer

@export var say:Array[String]
@onready var label = $Label

func read():
	
	for i in say:
		label.text = i
		var tween : Tween = create_tween()
		tween.tween_property(label,"visible_ratio",1.0,1.0).from(0.0)
		await get_tree().create_timer(4.0).timeout
	self.visible = false
	
