extends CharacterBody2D
var a = 1
var fireball_scene = preload("res://Fireball.tscn")
var firing: bool
@onready var spawn_point = $Marker2D
func shoot(dir: Vector2):
	var fireball = fireball_scene.instantiate()
	fireball.position = spawn_point.global_position
	fireball.direction = dir
	get_tree().root.add_child(fireball)
func summon_enemy(position):
	


func _on_fireball_timer_timeout() -> void:
	if firing == true:
		shoot(Vector2(sin(a),1))
		a += 1


func _on_fire_enemy_summon_timer_timeout() -> void:
	if firing == false:
		pass
