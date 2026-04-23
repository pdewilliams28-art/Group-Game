extends Node2D
@onready var pause_menu: Control = %"Pause Menu"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_pause()
	if %"Pause Menu".paused == false:
		toggle_pause()

func toggle_pause():
	var tree = get_tree()
	if tree.paused == false:
		tree.paused = true
		pause_menu.visible = true
		%"Pause Menu".paused = true
	else:
		tree.paused = false
		pause_menu.visible = false
		%"Pause Menu".paused = true


func _on_pause_menu_resume_button_pressed() -> void:
	toggle_pause()
