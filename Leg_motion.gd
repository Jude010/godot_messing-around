extends Marker3D


@export var target:Node3D 
@export var step_distance:float = 1
@export var neighbors:Array[Node3D]


var stepping:bool = false
var resting:bool = false


func step(delta) ->void:
	stepping = true
	var target_pos = target.global_position
	var halfway = (global_position + target_pos)/2
	var step_height = global_position.distance_to(target_pos)/2
	
	var tween = create_tween()
	tween.tween_property(self , "global_position", halfway + owner.basis.y, 0.1)
	tween.tween_property(self, "global_position", target_pos , 0.1)
	tween.tween_callback(func():resting = true)
	tween.tween_callback(func(): stepping = false)
	
		
	
func _physics_process(delta: float) -> void:
	var aj_step = false
	for i in neighbors:
		if i.stepping:
			aj_step =  true

	if global_position.distance_to(target.global_position) > step_distance && !stepping && !aj_step && !resting:
		step(delta)
	
	if !stepping:
		resting = false
