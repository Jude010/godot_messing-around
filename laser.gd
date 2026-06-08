@tool
extends RayCast3D

var mesh:ImmediateMesh

func _ready() -> void:
	mesh = $MeshInstance3D.mesh
	
	
func draw_laser(target_pos:Vector3) -> void:
	mesh.clear_surfaces()
	mesh.surface_begin(Mesh.PRIMITIVE_LINE_STRIP)
	mesh.surface_add_vertex(Vector3(0,0,0))
	mesh.surface_add_vertex(Vector3(target_pos))
	
	mesh.surface_end()

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		var pos = $Marker3D.position
		draw_laser(Vector3(pos.x,pos.z,-pos.y))
	elif is_colliding() :
		var target_pos = get_collision_point()
		var pos = to_local(target_pos)
		draw_laser(Vector3(pos.x,pos.z,-pos.y))
		$MeshInstance3D3.global_position = target_pos
		$MeshInstance3D4.position = pos
	else :
		var pos = target_position
		draw_laser(Vector3(pos.x,pos.z,-pos.y))
		$MeshInstance3D3.position = pos
	
