extends CharacterBody2D

var fireball_scene = preload("res://Fireball.tscn")
@onready var spawn_point = $Marker2D

func shoot(dir: Vector2):
	var fireball = fireball_scene.instantiate()
	fireball.position = spawn_point.global_position
	fireball.direction = dir
	get_tree().root.add_child(fireball)

# Example: Shooting downwards
func _on_timer_timeout():
	shoot(Vector2.DOWN) # Use Vector2(1,1).normalized() for down-right etc.
