extends Label

var count:float = 0


func _process(_delta: float) -> void:
	count += _delta
	text = "FPS: %s \n %f " % [Engine.get_frames_per_second() ,rad_to_deg( $"..".rotation.y) ]
