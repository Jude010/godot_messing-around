extends Camera3D

var target:Node3D
var tween:Tween
@export var ray_len:float = 10

var target_pos:Vector3
var ray:RayCast3D


func _ready():
	make_current()
	target = $"../Camera_container/SpringArm3D/Camera_marker"
	ray = $RayCast3D
	
	global_position = target.global_position
	global_basis = target.global_basis
	
	ray.target_position = Vector3.FORWARD * ray_len
	
func _physics_process(_delta: float) -> void:
	tween = create_tween()
	tween.tween_property(self , "global_basis" , target.global_basis , 0.1)
	tween.parallel().tween_property(self, "global_position", target.global_position , 0.2)
	
	if ray.is_colliding():
		target_pos = ray.get_collision_point()
	else:
		target_pos = to_global(ray.target_position)
	
	$Meshinstance3D.global_position = target_pos
