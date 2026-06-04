#extends Node3D
#
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	if GameState.next_tp_point_name != "":
#		var tp_point = get_node_or_null(GameState.next_tp_point_name)
#		if tp_point:
#			global_transform = tp_point.global_transform
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
#
extends Node3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	if GameState.next_tp_point_name == "":
		print("no tp point set")
		return

	var tp_point = find_child(GameState.next_tp_point_name, true, false)
	if tp_point == null:
		print("tp point not found: ", GameState.next_tp_point_name)
		return

	var player = get_node_or_null("Player")
	if player == null:
		print("Player not found in hq_rooms")
		return

	var t = tp_point.global_transform
	t.origin.y += 1.5
	player.global_transform = t

	print("moved PLAYER to ", tp_point.name, " pos: ", player.global_position)
