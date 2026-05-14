extends Area2D

@export var interact_type = 1
var paper_sprite = "res://Sprites/Paper-2.png.png"
@export var text = "hello world!"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if interact_type == 1:
		$Sprite2D.texture = paper_sprite
	if interact_type == 2:
		pass
