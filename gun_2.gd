extends Node3D

@export var proj:PackedScene
@export var rate:float = 1
@export var velocity:float = 1
@export var max_proj:int = 20

var projectiles:Array[RigidBody3D]

var view:Camera3D 
var target:Node3D 

func shoot() ->void:
	#spawn bullet with velocity at muzzle
	if projectiles.size() >= max_proj:
		projectiles[-1].queue_free()
		projectiles.remove_at(-1)
	var bullet:RigidBody3D = proj.instantiate()
	add_child(bullet)
	bullet.global_position = $Muzzle.global_position
	bullet.global_basis = $Muzzle.global_basis
	bullet.set_vel(velocity)
	projectiles.push_front(bullet)
	#set timer to delete bullet
	

func _input(event) -> void:
	if event.is_action_pressed("shoot"):
		shoot()
		
func remove_bullet(bullet:RigidBody3D) -> void:
	projectiles.erase(bullet)


func _ready() -> void:
	view = $"../../Camera3D"
	target = $target_node

func _physics_process(delta: float) -> void:
	var tween = create_tween()
	tween.tween_property(target,"global_position" , view.target_pos , .1)
	
	look_at(target.global_position)
