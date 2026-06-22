extends Node3D
var children:Array[RayCast3D] = []

var reach: float:
	get:
		var count:float = 0
		for i in children:
			count += i.target_position.length()
		count /= children.size()
		return count
	set(new):
		for i in children:
			i.target_position = Vector3.DOWN * new
			
		
func _ready() -> void:
	for i:Node3D in get_children():
		if i.is_class("RayCast3D"):
			children.push_back(i)

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
	
func basis_from_normal(normal:Vector3) -> Basis:
	var result = Basis()
	result.y = normal
	result.x = normal.cross(transform.basis.z)
	
	result.z = transform.basis.x.cross(normal)
	
	if result.x == Vector3.ZERO:
		result.x = transform.basis.x
		print('x')
	if result.y == Vector3.ZERO:
		result.y = transform.basis.y
		print('y')
	if result.z == Vector3.ZERO:
		result.z = transform.basis.z
		print('z')

	result.x *= scale.x
	result.y *= scale.y
	result.z *= scale.z
	
	if result.x == Vector3.ZERO:
		print('sx')
	if result.y == Vector3.ZERO:
		print('sy')
	if result.z == Vector3.ZERO:
		print('sz')
	
	return result
	
	
func get_normal_basis() -> Basis:
	var temp_normal = get_avg_normals()
	return basis_from_normal(temp_normal)
		
	
func _physics_process(_delta: float) -> void:
	var temp_basis = get_normal_basis()
	if temp_basis.x == Vector3.ZERO:
		print('rx')
	if temp_basis.y == Vector3.ZERO:
		print('ry')
	if temp_basis.z == Vector3.ZERO:
		print('rz')
	basis = Basis(basis.get_rotation_quaternion().slerp(temp_basis.get_rotation_quaternion(), 1))
