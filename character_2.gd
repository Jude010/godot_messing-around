@tool
extends CharacterBody3D

var mesh:ImmediateMesh
@export var mat : StandardMaterial3D
func _ready() -> void:
	mesh = $MeshInstance3D.mesh
	
	
func draw_laser() -> void:
	mesh.clear_surfaces()
	mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
	mesh.surface_set_uv(Vector2(1,1))
	mesh.surface_set_normal(Vector3.UP)
	mesh.surface_set_color(Color.RED)
	mesh.surface_add_vertex(Vector3(0,0,0))
	mesh.surface_set_uv(Vector2(1,0))
	mesh.surface_set_normal(Vector3.UP)
	mesh.surface_set_color(Color.RED)
	mesh.surface_add_vertex(Vector3(1,1,1))
	mesh.surface_set_uv(Vector2(0,1))
	mesh.surface_set_normal(Vector3.UP)
	mesh.surface_set_color(Color.RED)
	mesh.surface_add_vertex(Vector3(0,2,0))
	mesh.surface_end()
	for i in range(mesh.get_surface_count()):
		mesh.surface_set_material(i , mat)

func _process(_delta: float) -> void:
	draw_laser()
