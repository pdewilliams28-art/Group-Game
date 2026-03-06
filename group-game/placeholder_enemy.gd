extends CharacterBody2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
var target: Node2D

func _physics_process(delta: float) -> void:
	pass
	chase_target(target)
	move_and_slide()
func chase_target(target):
	pass

func _on_detection_range_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body
