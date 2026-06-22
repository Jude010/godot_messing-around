extends CharacterBody3D

@export var speed:float = 1
@export var max_speed:float = 5
@export var speed_r:float = 3
@export var damping:float = 0.9
@export var body:Node3D

@export var ground_offset:float = .75


var velocity_accumulator:Vector3 = Vector3.ZERO

@onready var camera:Camera3D = $Camera3D


func movement() ->void:
	var dir:Vector3 = Vector3.ZERO
	# take input 
	if Input.is_action_pressed("forward"):
		dir.z -= 1
	if Input.is_action_pressed("back"):
		dir.z += 1
	if Input.is_action_pressed("left"):
		dir.x -= 1
	if Input.is_action_pressed("right"):
		dir.x += 1
	if Input.is_action_pressed("UP"):
		dir.y +=1 
	if Input.is_action_pressed("Down"):
		dir.y -=1
	
	#normalize damp rotate etc
	dir = dir.normalized()
	
	var normals_basis = $SurfaceDetector.get_normal_basis()
	
	dir = (normals_basis*dir).normalized()
	dir = dir.rotated(normals_basis.y , $Camera_container/SpringArm3D.rotation.y)
	
	#apply to velocity accumultator
	velocity_accumulator += dir * speed
	velocity_accumulator = velocity_accumulator.limit_length(max_speed)
	velocity_accumulator *= damping
	
	#rotate to face camera if moving
	if dir != Vector3.ZERO :
		body.rotation.y = rotate_toward(body.rotation.y , camera.rotation.y , TAU/64)
	
	
func _physics_process(_delta):
	movement()
	velocity = velocity_accumulator
	set_up_direction($SurfaceDetector.get_avg_normals())
	
	
	move_and_slide()
	
