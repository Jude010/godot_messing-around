extends MeshInstance3D

@onready var shoot:GPUParticles3D = $shoot/Tracers
@export var rate:int = 8

func _ready():
	shoot.amount = rate

func _physics_process(_delta):
	
	if Input.is_action_pressed("shoot"):
		shoot.emitting = true
	else:
		shoot.emitting = false
