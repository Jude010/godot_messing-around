extends CharacterBody3D

@export var speed:int = 1
@export var max_speed:int = 5
@export var speed_r:int = 3
@export var damping:float = 0.9


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
	
	#normalize damp rotate etc
	dir = dir.normalized()
	
	velocity_accumulator *= damping
	
	dir = dir.rotated(Vector3.UP , camera.global_rotation.y)
	
	#apply to velocity accumultator
	velocity_accumulator += dir * speed
	velocity_accumulator = velocity_accumulator.limit_length(max_speed)
	
	if dir != Vector3.ZERO :
		$MeshInstance3D.global_rotation.y = rotate_toward($MeshInstance3D.global_rotation.y , camera.global_rotation.y , PI/32)
	
	

func _physics_process(delta):
	
	var rot:int = 0
	var dir:Vector3 = Vector3.ZERO
	
	if Input.is_action_pressed("Q"):
		rot += 1
	if Input.is_action_pressed("E"):
		rot -= 1
	
	if Input.is_action_pressed("forward"):
		dir.z -= 1
	if Input.is_action_pressed("back"):
		dir.z += 1
	if Input.is_action_pressed("left"):
		dir.x -= 1
	if Input.is_action_pressed("right"):
		dir.x += 1
	
	
	rotate_y(speed_r * rot * delta)
	
	movement()
	
	velocity = velocity_accumulator
	
	
	move_and_slide()
	
