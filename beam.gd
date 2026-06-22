@tool
extends Node3D

@export var side_count:int = 3
@export var radius:float = .1
@export_group("colours")
@export var material:StandardMaterial3D
@export var start_colour:Color = Color.CRIMSON
@export var end_colour:Color = Color.AQUAMARINE
@export var change_curve:Curve


var target:Vector3
@onready var ray = $RayCast3D
@onready var mesh:ImmediateMesh = $MeshInstance3D.mesh


func check_target() -> void:
	if ray.is_colliding():
		target = ray.get_collision_point()
	else:
		target = ray.target_position
		
func _ready() -> void:
	check_target()
	
func calc_circle_points(point:Vector3) -> Array[Vector3]:
	var points:Array[Vector3] = []
	#find point use rotate to find extra points 
	for i in side_count:
		var point_n = point + Vector3.UP.rotated(Vector3.BACK , (i*TAU)/side_count)*radius
		points.push_back(point_n)
	return points
	
func draw_cylinder(start , end) -> void:
	var start_circle:Array[Vector3] = calc_circle_points(start)
	var end_circle:Array[Vector3] = calc_circle_points(end)
	var normal:Vector3
	
	mesh.clear_surfaces()
	mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLES)
	for i in side_count:
		var point_1 = start_circle[i]
		var point_2 = start_circle[(i+1)%side_count]
		var point_3 = end_circle[i]
		normal = Plane(point_1, point_2, point_3).normal
		mesh.surface_set_normal(normal)
		mesh.surface_add_vertex(point_1)
		mesh.surface_set_normal(normal)
		mesh.surface_add_vertex(point_2)
		mesh.surface_set_normal(normal)
		mesh.surface_add_vertex(point_3)
		
		point_1 = end_circle[i]
		point_2 = start_circle[(i+1)%side_count]
		point_3 = end_circle[(i+1)%side_count]
		normal = Plane(point_1, point_2, point_3).normal
		mesh.surface_set_normal(normal)
		mesh.surface_add_vertex(point_1)
		mesh.surface_set_normal(normal)
		mesh.surface_add_vertex(point_2)
		mesh.surface_set_normal(normal)
		mesh.surface_add_vertex(point_3)
	mesh.surface_end()
	mesh.surface_set_material(0 , material)

func _physics_process(delta: float) -> void:
	check_target()
	draw_cylinder(position , target)
	
	
