extends RayCast3D

var target:Node3D

func _ready() -> void:
	target = get_child(0)

func _physics_process(_delta: float) -> void:
	if is_colliding() :
		target.global_position = get_collision_point()
