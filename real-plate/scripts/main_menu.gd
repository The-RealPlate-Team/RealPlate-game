extends Control

func _ready():
	# Make sure the mouse cursor is visible on the menu
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$PlayButton.grab_focus()   # ← Controller starts here

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/hq.tscn")

func _on_settings_button_pressed():
	pass  # We'll build this later!

func _on_quit_button_pressed():
	get_tree().quit()

func _on_char_edit_pressed():
	get_tree().change_scene_to_file("res://scenes/character_edit.tscn")
