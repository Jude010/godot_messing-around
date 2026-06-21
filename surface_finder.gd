extends ShapeCast3D



func find_normals() -> Vector3:
	var avg_normals = Vector3.ZERO
	if is_colliding():
		for i in get_collision_count():
			avg_normals += get_collision_normal(i)
		
		avg_normals = (avg_normals/get_collision_count()).normalized()
	else:
		avg_normals = Vector3.UP
	
	return avg_normals

func basis_from_normal(normal:Vector3) -> Basis:
	var result = Basis()
	result.x = normal.cross(transform.basis.z)
	result.y = normal
	result.z = transform.basis.x.cross(normal)
	
	if result.x == Vector3.ZERO:
		result.x = Vector3.RIGHT
	if result.y == Vector3.ZERO:
		result.y = Vector3.UP
	if result.z == Vector3.ZERO:
		result.z = Vector3.BACK
		
	
	result = result.orthonormalized()
	result.x *= scale.x
	result.y *= scale.y
	result.z *= scale.z
	
	return result
	
func get_normal_basis() -> Basis:
	var temp_normal = find_normals()
	return basis_from_normal(temp_normal)
	
func _physics_process(_delta: float) -> void:
	var temp_basis = get_normal_basis().orthonormalized()
	global_basis = Basis(global_basis.get_rotation_quaternion().slerp(temp_basis.get_rotation_quaternion(), 1))
