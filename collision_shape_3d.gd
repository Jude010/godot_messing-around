extends CollisionShape3D

func _physics_process(delta: float) -> void:
	global_basis = get_parent_node_3d().body.global_basis
