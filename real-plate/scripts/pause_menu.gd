extends Control

func _ready():
	# Start hidden
	visible = false
	# This tells Godot: "process this node even when the game is paused"
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event):
	if event.is_action_pressed("pause"):  # ESC key by default
		toggle_pause()

func toggle_pause():
	visible = !visible
	get_tree().paused = visible
	# Show cursor when paused, lock it when playing
	if visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$CenterContainer/VBoxContainer/ResumeButton.grab_focus()   # ← Auto-select first button
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_resume_button_pressed():
	toggle_pause()

func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
