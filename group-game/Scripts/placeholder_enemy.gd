extends CharacterBody2D
@export var attributes: Enemy_resource
@onready var sprite : Sprite2D = $Sprite2D

var speed: float = 300
var target: Node2D
var damage: int = 1
var health: int = 3
var knockback: float = 3
func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	if target:
		chase_target()
	else:
		velocity = Vector2.ZERO
	move_and_slide()
func chase_target():
	var distance_to_player: Vector2
	distance_to_player = target.global_position - global_position
	var direction_normal: Vector2 = distance_to_player.normalized()
	velocity = direction_normal * speed

func _on_detection_range_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body

func _on_detection_range_body_exited(body: Node2D) -> void:
	if body is Player:
		target = null
