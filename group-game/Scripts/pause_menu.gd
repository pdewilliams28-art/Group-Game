extends Control
var Main_Menu = "res://Scenes/main_menu.tscn"
@export var paused = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pause_game() -> void:
	visible = true


func _on_button_unpause_game() -> void:
	visible = false


func _on_quit_to_main_menu_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred(Main_Menu)
	get_tree().paused = false


func _on_resume_pressed() -> void:
	paused = false
