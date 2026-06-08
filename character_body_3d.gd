extends CharacterBody3D

@export var speed:int = 10
@export var speed_r:int = 3

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
	
	velocity = global_transform.basis * speed * dir * delta
	
	
	move_and_slide()
	
