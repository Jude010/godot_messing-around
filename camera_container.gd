extends Node3D

@onready var surface_detector = $"../SurfaceDetector"


func _physics_process(_delta: float) -> void:
	var target_basis = surface_detector.get_normal_basis()
	var target_quat = target_basis.get_rotation_quaternion()
	basis = Basis(basis.get_rotation_quaternion().slerp(target_quat, 1))
