extends Control
signal resume_button_pressed

func _on_resume_pressed() -> void:
	emit_signal("resume_button_pressed")
