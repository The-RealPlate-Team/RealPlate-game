extends Area3D
signal player_entered(interactable)
signal player_exited(interactable)
@export var prompt_text: String = "Press E"

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("player_entered", self)

func _on_body_exited(body):
	if body.is_in_group("player"):
		emit_signal("player_exited", self)
