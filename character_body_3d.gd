extends CharacterBody3D

@export var speed:float = 1
@export var max_speed:float = 5
@export var speed_r:float = 3
@export var damping:float = 0.9
@export var body:Node3D

@export var ground_offset:float = .75


var velocity_accumulator:Vector3 = Vector3.ZERO

@onready var camera = $Camera3D


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
	
	velocity_accumulator *= damping
	
	dir = dir.rotated(Vector3.UP , camera.rotation.y)
	
	#apply to velocity accumultator
	velocity_accumulator += dir * speed
	velocity_accumulator = velocity_accumulator.limit_length(max_speed)
	
	#rotate to face camera if moving
	if dir != Vector3.ZERO :
		body.global_rotation.y = rotate_toward(body.global_rotation.y , camera.global_rotation.y , PI/32)
	

	
func _physics_process(delta):
	
	movement()
	velocity = velocity_accumulator
	
	
	move_and_slide()
	
