extends Node3D
@onready var body_cue: RigidBody3D = $RigidBody3D
@onready var ball_cue: Node3D = $"../ball_cue"

var power = 0
var shooting: bool = false
#const ball_cue.reset_pt = Vector2(0,0,0)

func _ready() -> void:
	body_cue.contact_monitor = true
	body_cue.max_contacts_reported = 12
	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		if power < 250:
			power += 5
			body_cue.freeze = false
	if Input.is_action_just_released("shoot"):
		body_cue.apply_force(Vector3(0, 0, power))
		power = 0
		shooting = true
	#if (ball_cue.position.y == -5.0):
		#ball_cue.position.x = 0
		#ball_cue.position.y = 0.1
		
	if Input.is_action_pressed("down"):
		position.z -= 1 * delta
	if Input.is_action_pressed("up"):
		position.z += 1 * delta
	if Input.is_action_pressed("left"):
		position.x -= 1 * delta
	if Input.is_action_pressed("right"):
		position.x += 1 * delta		
	if Input.is_action_pressed("lift"):
		position.y += 1 * delta
	if Input.is_action_pressed("lower"):
		position.y -= 1 * delta
	if Input.is_action_pressed("angle_down"):
		rotation.x += deg_to_rad(5 * delta)
	if Input.is_action_pressed("angle_up"):
		rotation.x += deg_to_rad(-5 * delta)
	if Input.is_action_pressed("angle_left"):
		rotation.y += deg_to_rad(-5 * delta)
	if Input.is_action_pressed("angle_right"):
		rotation.y += deg_to_rad(5 * delta)
	if Input.is_action_just_pressed("reset"):
		position.x = 0
		position.y = 0.8
		position.z = -1
		rotation.x = 0.3
		
	for i in body_cue.get_colliding_bodies():
		print(i.name)
		if i.name == "cueball" and shooting:
			body_cue.freeze = true
			var timer : Timer = Timer.new()
			timer.connect("timeout", reset)
			timer.wait_time = 1.5
			timer.one_shot = true
			add_child(timer)
			timer.start()
			shooting = false
func reset():
	body_cue.freeze = false
