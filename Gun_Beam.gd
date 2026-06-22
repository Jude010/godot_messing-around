extends Node3D

@export var shot:PackedScene
@export var range:float = 100

@export_category("Geometry")
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

var view:Camera3D 
var target:Node3D 

func _ready() -> void:
	view = $"../../Camera3D"
	target = $target_node

func shoot() ->void:
	pass

	

func _input(event) -> void:
	if event.is_action("shoot"):
		shoot()
		
func remove_beam(beam) -> void:
	pass




func _physics_process(_delta: float) -> void:
	var tween = create_tween()
	tween.tween_property(target,"global_position" , view.target_pos , .1)
	
	look_at(target.global_position , get_parent_node_3d().global_basis.y)
