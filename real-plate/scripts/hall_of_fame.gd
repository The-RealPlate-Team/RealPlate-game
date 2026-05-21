extends Area3D

@export var tp_point_name: String
func _on_body_entered(body) -> void:
	if body.name == "Player":
		body.current_station = self
	print("ENTERED: ", body.name)




func _on_body_exited(body) -> void:
	if body.name == "Player" and body.current_station == self:
		body.current_station = null
