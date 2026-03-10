extends CharacterBody3D


const SPEED = 6


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

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
#so you can move the camera
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * 0.003)
		$Camera3D.rotation.x -= event.relative.y * 0.003
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x, -1.6, 1.6)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().quit()
