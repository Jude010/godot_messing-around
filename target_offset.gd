extends Node3D

@export var offset:float = 20


@onready var parent:Node3D = self.get_parent_node_3d()
@onready var prev_pos:Vector3 = parent.global_position

func _physics_process(_delta) ->void:
	var velocity = parent.global_position - prev_pos
	global_position = parent.global_position + velocity * offset
	
	prev_pos = parent.global_position
