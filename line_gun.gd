extends Node3D

@export var range:int = 1
@onready var ray:RayCast3D = $RayCast3D

func _ready() -> void:
	ray.target_position = Vector3.FORWARD * range
	

func _shoot() -> void:
	var point:Vector3
	if ray.is_colliding() :
		point = ray.get_collision_point()
	else:
		point = global_transform * (Vector3.FORWARD * range)
		
	
