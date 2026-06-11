extends SpringArm3D

@export var mouse_sensitivity = 0.01
@export var scroll_scale = 0.1


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * mouse_sensitivity
		rotation.y = wrapf(rotation.y , 0.0 , TAU)
		
		rotation.x -= event.relative.y * mouse_sensitivity
		rotation.x = clamp(rotation.x , -PI/2 , PI/4)
	
	if event.is_action_pressed("mouse_wheel_up"):
		spring_length -= scroll_scale
		spring_length = clampf(spring_length , .1 , 6)
	
	if event.is_action_pressed("mouse_wheel_down"):
		spring_length += scroll_scale
		spring_length = clampf(spring_length , .1 , 6)
