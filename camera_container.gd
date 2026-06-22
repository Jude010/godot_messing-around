extends Node3D

func basis_from_normal(normal:Vector3) -> Basis:
	var result = Basis()
	result.x = normal.cross(transform.basis.z)
	result.y = normal
	result.z = transform.basis.x.cross(normal)
	
	if result.x == Vector3.ZERO:
		result.x = transform.basis.x
	if result.y == Vector3.ZERO:
		result.y = Vector3.UP
	if result.z == Vector3.ZERO:
		result.z = transform.basis.z
	
	#result = result.orthonormalized()
	result.x *= scale.x
	result.y *= scale.y
	result.z *= scale.z
	
	return result

func _physics_process(_delta: float) -> void:
	basis = Basis(basis.get_rotation_quaternion().slerp(basis_from_normal($"../SurfaceDetector".get_avg_normals()).get_rotation_quaternion(), 1))
