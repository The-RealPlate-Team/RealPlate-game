extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	if GameState.next_tp_point_name != "":
		var tp_point = get_node_or_null(GameState.next_tp_point_name)
		if tp_point:
			global_transform = tp_point.global_transform


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
