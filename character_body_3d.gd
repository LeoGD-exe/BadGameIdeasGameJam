extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
#Lock the mouse to the screen so you cant move it 
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

var mouse_position: Vector2
var Camera = Camera3D
var mouse_rotation_max_x = 1.5
var mouse_rotation_min_x = -1.5
var mouse_rotation_now = 0.00
#so you can move the camera
func _input(event):
	if event is InputEventMouseMotion:
		mouse_position = event.screen_relative
		rotate_y(-event.screen_relative.x * 0.003)
		rotate_x(-event.screen_relative.y * 0.003)	
		
		mouse_rotation_now += mouse_rotation_now * -0.001
		mouse_rotation_now = clamp(mouse_rotation_max_x,mouse_rotation_min_x,mouse_rotation_now)
		
		
		
		
		
	
