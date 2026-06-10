@tool
extends RayCast3D

var mesh:ImmediateMesh

@export var mat : StandardMaterial3D

func _ready() -> void:
	mesh = $MeshInstance3D.mesh
	
	
func draw_laser(target_pos:Vector3) -> void:
	mesh.clear_surfaces()
	mesh.surface_begin(Mesh.PRIMITIVE_LINE_STRIP)
	mesh.surface_set_normal(Vector3.FORWARD)
	mesh.surface_set_color(Color.RED)
	mesh.surface_add_vertex(Vector3(0,0,0))
	mesh.surface_set_normal(Vector3.FORWARD)
	mesh.surface_set_color(Color.RED)
	mesh.surface_add_vertex(target_pos)
	mesh.surface_end()
	mesh.surface_set_material( 0 , mat)

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		var pos = $Marker3D.position
		draw_laser(Vector3(pos.x,pos.z,-pos.y))
		$MeshInstance3D2.position = pos
	elif is_colliding() :
		var target_pos = get_collision_point()
		var pos = to_local(target_pos)
		draw_laser(Vector3(pos.x,pos.z,-pos.y))
		$MeshInstance3D2.position = pos
	else :
		var pos = target_position
		draw_laser(Vector3(pos.x,pos.z,-pos.y))
		$MeshInstance3D2.position = pos
	
