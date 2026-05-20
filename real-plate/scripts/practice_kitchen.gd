extends Area3D

@export var tp_point_name: String



func _on_area_entered(area: Area3D) -> void:
	pass # Replace with function area.


func _on_area_exited(area: Area3D) -> void:
	if area.name == "Player" and area.current_station == self:
		area.current_station = null
