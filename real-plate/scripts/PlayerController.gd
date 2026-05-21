extends CharacterBody3D

@onready var cam_fp = $Player_1st_Person
@onready var cam_tp = $"../Player_3rd_Person"
@onready var lights_root = $"../Lights"

var mouse_sensitivity := 0.003
var controller_sensitivity := 2.0
var vertical_limit := 85.0
var current_station = null


const SPEED := 5.0
const JUMP_VELOCITY := 4.5

var is_first_person := true


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	cam_fp.current = true
	cam_tp.current = false
	_update_light_models_visibility()
	print("cam_fp.curent = " + str(cam_fp.current))
	print("cam_tp.current = " + str(cam_tp.current))


func _physics_process(delta: float) -> void:
	# GRAVITY
	if not is_on_floor():
		velocity += get_gravity() * delta

	# JUMP
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# ---------------------------------------------------------
	# MOVEMENT (WORLD SPACE — prevents spinning)
	# ---------------------------------------------------------
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction != Vector3.ZERO:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# ---------------------------------------------------------
	# THIRD-PERSON ROTATION (ONLY in TP mode)
	# ---------------------------------------------------------
	if !is_first_person:
		if direction != Vector3.ZERO:
			var target_rot := atan2(direction.x, direction.z)
			rotation.y = lerp_angle(rotation.y, target_rot, delta * 10.0)

	# ---------------------------------------------------------
	# CONTROLLER LOOK (ONLY in FP mode)
	# ---------------------------------------------------------
	if is_first_person:
		var look_x := Input.get_action_strength("camera_right") - Input.get_action_strength("camera_left")
		var look_y := Input.get_action_strength("camera_down") - Input.get_action_strength("camera_up")

		rotation.y -= look_x * controller_sensitivity * delta

		cam_fp.rotate_x(-look_y * controller_sensitivity * delta)
		cam_fp.rotation_degrees.x = clamp(cam_fp.rotation_degrees.x, -vertical_limit, vertical_limit)

	move_and_slide()


func _input(event):
	# CAMERA TOGGLE
	#if event.is_action_pressed("toggle_camera"):
		#switch_camera()

	# MOUSE LOOK (ONLY in FP mode)
	if event is InputEventMouseMotion and is_first_person:
		rotation.y -= event.relative.x * mouse_sensitivity
		cam_fp.rotate_x(-event.relative.y * mouse_sensitivity)
		cam_fp.rotation_degrees.x = clamp(cam_fp.rotation_degrees.x, -vertical_limit, vertical_limit)
	
	if event.is_action_pressed("interact"):
		if current_station !=null:
			GameState.next_tp_point_name = current_station.tp_point_name
			get_tree().change_scene_to_file("res://scenes/hq_rooms.tscn")

func switch_camera():
	is_first_person = !is_first_person

	cam_fp.current = is_first_person
	cam_tp.current = !is_first_person

	_update_light_models_visibility()

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _update_light_models_visibility():
	var show_models := is_first_person

	if lights_root == null:
		return

	for light in lights_root.get_children():
		if light.has_node("Root"):
			var model := light.get_node("Root")
			model.visible = show_models
