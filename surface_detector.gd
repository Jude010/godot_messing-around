extends Node3D
var children:Array[RayCast3D] = []
@onready var shape_cast:ShapeCast3D = $Down
@export var reach:float =1.5

@onready var camera = $"../Camera3D"

var length: float:
	get:
		var count:float = 0
		count += shape_cast.shape.radius 
		for i in children:
			count += i.target_position.length()
		count /= children.size() + 1
		return count
	set(new):
		shape_cast.shape.radius = new
		for i in children:
			i.target_position = Vector3.DOWN * new
			


func _ready() -> void:
	for i:Node3D in get_children():
		if i.is_class("RayCast3D"):
			children.push_back(i)
	length = reach


func get_avg_normals() ->Vector3:
	var normals:Vector3 = Vector3.ZERO
	var count:int = 0
	for i in children :
		if i .is_colliding():
			normals += i.get_collision_normal()
			count += 1
	
	if count == 0:
		return Vector3.UP
	else:
		normals = (normals/count).normalized()
		return normals


func basis_from_normal(normal:Vector3 , target) -> Basis:
	var result = Basis()
	result.y = normal
	result.x = normal.cross(target.transform.basis.z)
	result.z = target.transform.basis.x.cross(normal)
	
	if result.x == Vector3.ZERO:
		result.x = target.transform.basis.x
	if result.y == Vector3.ZERO:
		result.y = target.transform.basis.y
	if result.z == Vector3.ZERO:
		result.z = target.transform.basis.z

	result.x *= target.scale.x
	result.y *= target.scale.y
	result.z *= target.scale.z
	
	return result


func get_normal_basis_to_camera(target:Node3D = self) -> Basis:
	var temp_normal = get_avg_normals()
	if is_colliding() :
		return basis_from_normal(temp_normal , target)
	else: 
		var result:Basis = Basis()
		result.y = Vector3.UP
		result.z = Vector3(camera.basis.z.x ,
				0.0 ,
				camera.basis.z.z).normalized()
		result.x = result.y.cross(result.z)
		return result


func get_normal_basis(target:Node3D = self ) -> Basis:
	var temp_normal = get_avg_normals()
	if is_colliding():
		return basis_from_normal(temp_normal , target)
	else:
		return Basis()

func is_colliding() -> bool:
	for i in children:
		if i.is_colliding():
			return true
	return false


func _physics_process(_delta: float) -> void:
	var temp_basis:Basis = get_normal_basis()
	var temp_quat:Quaternion = temp_basis.get_rotation_quaternion()
	basis = Basis(basis.get_rotation_quaternion().slerp(temp_quat, 1))
