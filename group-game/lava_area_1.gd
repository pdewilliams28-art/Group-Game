extends Area2D

var bodies_on_button: int = 0

signal pressed
signal unpressed


func _on_body_entered(body):
	bodies_on_button += 1
	if body.is_in_group("Movable") or body is Player:
		if bodies_on_button == 1:
			pressed.emit()
			print("blocky")

func _on_body_exited(body):
	bodies_on_button -= 1
	if body.is_in_group("Movable") or body is Player:
		if bodies_on_button == 0:
			unpressed.emit()
			print("non blocky")
