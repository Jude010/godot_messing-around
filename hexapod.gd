extends Node3D

@onready var fl_leg = $FL_Target
@onready var ml_leg = $ML_Target
@onready var bl_leg = $BL_Target
@onready var fr_leg = $FR_Target
@onready var mr_leg = $MR_Target
@onready var br_leg = $BR_Target

@onready var surface_detector:Node3D = $"../SurfaceDetector"


func calc_average_leg_normal() -> Vector3:
	var plane1:Plane = Plane(bl_leg.global_position , fl_leg.global_position , mr_leg.global_position)
	var plane2:Plane = Plane(fr_leg.global_position , br_leg.global_position , ml_leg.global_position)
		
	var avg_normal: = ((plane1.normal + plane2.normal)/2).normalized()
	return avg_normal


func _physics_process(_delta: float) -> void:
	var target_basis:Basis = surface_detector.get_normal_basis_to_camera(self)
	var target_quat:Quaternion = target_basis.get_rotation_quaternion()
	global_basis = Basis(global_basis.get_rotation_quaternion().slerp(target_quat , .1))
	
	
