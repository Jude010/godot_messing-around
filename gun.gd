extends MeshInstance3D

@onready var shoot:GPUParticles3D = $shoot/GPUParticles3D

func _ready():
	print("ready")

func _physics_process(_delta):
	
	if Input.is_action_pressed("shoot"):
		print("w")
		self.shoot.restart()
