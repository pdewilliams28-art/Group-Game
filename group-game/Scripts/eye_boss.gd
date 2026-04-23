extends CharacterBody2D
var fireball_direction = 1
var fireball_scene = preload("res://Scenes/fireball.tscn")
var firing: bool = false
var flame_enemy_scene = preload("res://Scenes/placeholder_enemy.tscn")
var flame_enemy_resource: Enemy_resource = preload("res://Resources/Fire_enemy.tres")
@onready var spawn_point = $Marker2D
func shoot(dir: Vector2):
	var fireball = fireball_scene.instantiate()
	fireball.position = spawn_point.global_position
	fireball.direction = dir
	get_tree().root.add_child(fireball)
func summon_enemy(position):
	var new_instance = flame_enemy_scene.instantiate()
	new_instance.attributes = flame_enemy_resource
	new_instance.global_position = position
	get_parent().add_child(new_instance)


func _on_fireball_timer_timeout() -> void:
	if firing == true:
		shoot(Vector2(sin(fireball_direction),1))
		fireball_direction += 1


func _on_fire_enemy_summon_timer_timeout() -> void:
	if firing == false:
		summon_enemy(Vector2(global_position.x,global_position.y + 500))


func _on_boss_phase_switch_timer_timeout() -> void:
	if firing == false:
		firing = true
	else:
		firing = false
