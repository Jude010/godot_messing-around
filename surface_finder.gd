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
	
	result = result.orthonormalized()
	result.x *= scale.x
	result.y *= scale.y
	result.z *= scale.z
	
	return result
	
	
func _physics_process(delta: float) -> void:
	global_basis = quaternion.slerp(Quaternion(basis_from_normal(find_normals())), 1)
	
	if Input.is_action_pressed("shoot"):
		print(find_normals())
