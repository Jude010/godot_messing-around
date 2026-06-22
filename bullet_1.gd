extends RigidBody3D

var mark_for_delete:bool = false

func set_vel(vel: float) -> void :
	linear_velocity = vel * global_position.direction_to(to_global(Vector3.FORWARD))
	


func _on_body_entered(_body: Node) -> void:
	#get_parent().remove_bullet(self)
	#for i in get_children():
		#if ! i is GPUParticles3D:
			#i.queue_free()
	#mark_for_delete = true
	$GPUParticles3D.emitting = false


func _on_gpu_particles_3d_finished() -> void:
	get_parent().remove_bullet(self)
	if mark_for_delete :
		self.queue_free()
