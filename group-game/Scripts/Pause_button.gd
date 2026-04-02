extends Button
signal pause_game
signal unpause_game
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		pause_toggle()
func pause_toggle():
	if get_tree().paused == false:
		get_tree().paused = true
		emit_signal("pause_game")
		visible = false
	else:
		get_tree().paused = false
		emit_signal("unpause_game")
		visible = true

func _on_pressed() -> void:
	pause_toggle()



func _on_pause_menu_unpause_game() -> void:
	pause_toggle()
