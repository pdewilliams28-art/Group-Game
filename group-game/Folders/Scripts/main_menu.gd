extends MarginContainer
@export var Current_Scene = "res://Folders/Scenes/Main_Scene.tscn"
var Settings = false
var volume: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Settings == true:
		$PanelContainer.visible = false
		$Settings.visible = true
	if Settings == false:
		$PanelContainer.visible = true
		$Settings.visible = false


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred(Current_Scene)
	get_tree().paused = false


func _on_settings_button_pressed() -> void:
	Settings = true


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_main_button_pressed() -> void:
	Settings = false


func _on_volume_slider_value_changed(value: float) -> void:
	print(value)
	volume = value
	$Settings/MarginContainer/HBoxContainer/VBoxContainer/Label3.text = str(volume) + "%"
