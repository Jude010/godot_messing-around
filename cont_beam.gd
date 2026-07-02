class_name Hitscan_shot extends Node3D

@export var shot:PackedScene

@export var lifetime:float = 10

@export_category("Geometry")
@export_group('Advanced')
@export var side_min:int = 3
@export var side_max:int = 3
@export var side_curve:Curve
@export var radius_min:float = .1
@export var radius_max:float = .1
@export var radius_curve:Curve

@export_category("colours")
@export var material:StandardMaterial3D
@export var color_gradient:Gradient
@export var transperency_curve:Curve

var beam_shooting:Node3D = null


func start_shoot() -> void:
	beam_shooting = shot.instantiate()
	
func con_shoot() -> void:
	pass
	
func shoot() -> void:
	pass
