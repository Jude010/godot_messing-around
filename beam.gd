@tool
extends Node3D

@export var lifetime:float = 2

@export_category("Geometry")
@export var side_count:int = 3
@export var radius:float = .1
@export_group('Advanced')
@export var side_start:int = 3
@export var side_end:int = 3
@export var side_curve:Curve = Curve.new()
@export var radius_start:float = .1
@export var radius_end:float = .1
@export var radius_curve:Curve = Curve.new()

@export_category("colours")
@export var material:StandardMaterial3D
@export var start_colour:Color = Color.BLACK
@export var end_colour:Color = Color.WHITE
@export var color_gradient:Gradient = Gradient.new()
@export var transperency_curve:Curve

var time_accumulator:float = 0



var target:Vector3
@onready var ray = $RayCast3D
@onready var mesh:ImmediateMesh = $MeshInstance3D.mesh

func _ready() -> void:
	check_target()
	color_gradient.set_color(0 , start_colour)
	color_gradient.set_color(1,end_colour)

func check_target() -> void:
	if ray.is_colliding():
		target = ray.get_collision_point()
	else:
		target = ray.target_position
		
	
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
	
	#for each point in circle draw both triangles used in its face
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
		
		mesh.surface_set_normal(normal*-1)
		mesh.surface_add_vertex(point_3)
		mesh.surface_set_normal(normal*-1)
		mesh.surface_add_vertex(point_2)
		mesh.surface_set_normal(normal*-1)
		mesh.surface_add_vertex(point_1)
		
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
		
		mesh.surface_set_normal(normal*-1)
		mesh.surface_add_vertex(point_3)
		mesh.surface_set_normal(normal*-1)
		mesh.surface_add_vertex(point_2)
		mesh.surface_set_normal(normal*-1)
		mesh.surface_add_vertex(point_1)
		
		
	mesh.surface_end()
	mesh.surface_set_material(0 , material)


func color_interp():
	var normalised_time = time_accumulator/lifetime
	material.albedo_color = color_gradient.sample(normalised_time)
	material.emission = color_gradient.sample(normalised_time)
	
func side_interp():
	var normalised_time = time_accumulator/lifetime
	var side_dif = side_end - side_start
	side_count = side_start + int(side_dif*side_curve.sample(normalised_time))
	
func rad_interp():
	var normalised_time = time_accumulator/lifetime
	var rad_dif = radius_end - radius_start
	radius = radius_start + rad_dif*radius_curve.sample(normalised_time)
	
func transperency_interp():
	var normalised_time = time_accumulator/lifetime
	start_colour.a = transperency_curve.sample(normalised_time)
	end_colour.a = transperency_curve.sample(normalised_time)


func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		color_gradient.set_color(0 , start_colour)
		color_gradient.set_color(1,end_colour)
		check_target()
	draw_cylinder(position , target)
	color_interp()
	side_interp()
	rad_interp()
	transperency_interp()
	
	time_accumulator += delta
	time_accumulator = fmod(time_accumulator , lifetime)
	
