extends Area2D

@export var Current_Scene = "res://boss_scene.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	print("tunnel")
	if area.is_in_group("Player") == true:
		get_tree().change_scene_to_file.call_deferred(Current_Scene)
		get_tree().paused = false
