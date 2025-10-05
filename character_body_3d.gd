extends CharacterBody3D

@export var speed:int = 10
@export var speed_r:int = 3

func _physics_process(delta):
	
	var rot:int = 0
	var dir:int = 0
	
	if Input.is_action_pressed("left"):
		rot += 1
	if Input.is_action_pressed("right"):
		rot -= 1
	
	if Input.is_action_pressed("forward"):
		dir += 1
	if Input.is_action_pressed("back"):
		dir -= 1
	
	rotate_y(speed_r * rot * delta)
	
	velocity = global_transform.basis * Vector3.FORWARD * speed * dir
	
	
	move_and_slide()
	
