extends Area3D

@export var tp_point_name: String

func _on_area_exited(area):
	if area.name == "Player" and area.current_station == self:
		area.current_station = null


func _on_area_entered(area: Area3D) -> void:
	if area.name == "Player":
		area.current_station = self
