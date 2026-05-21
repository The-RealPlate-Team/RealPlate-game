extends Area3D

@export var tp_point_name: String




func _on_body_entered(body: Area3D) -> void:
	if body.name == "Player":
		body.current_station = self


func _on_body_exited(body: Area3D) -> void:
	if body.name == "Player" and body.current_station == self:
		body.current_station = null
