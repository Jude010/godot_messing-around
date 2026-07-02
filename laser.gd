@tool
extends RayCast3D
@export var frame_offset:int = 10
var frame_count:int = 0

var mesh:ImmediateMesh

@export var mat : StandardMaterial3D

func _ready() -> void:
	mesh = $MeshInstance3D.mesh
	
	
func draw_laser(target_pos:Vector3) -> void:
	mesh.clear_surfaces()
	mesh.surface_begin(Mesh.PRIMITIVE_LINE_STRIP)
	mesh.surface_add_vertex(Vector3(0,0,0))
	mesh.surface_add_vertex(target_pos)
	mesh.surface_end()
	mesh.surface_set_material( 0 , mat)

func _process(_delta: float) -> void:
	if Engine.is_editor_hint()and frame_count ==0:
		var pos = $Marker3D.position
		draw_laser(Vector3(pos.x,pos.z,-pos.y))
	elif is_colliding() and frame_count ==0:
		var target_pos = get_collision_point()
		var pos = to_local(target_pos)
		draw_laser(Vector3(pos.x,pos.z,-pos.y))
	elif frame_count ==0:
		var pos = target_position
		draw_laser(Vector3(pos.x,pos.z,-pos.y))
	
	frame_count += 1
	frame_count = frame_count % frame_offset
	
