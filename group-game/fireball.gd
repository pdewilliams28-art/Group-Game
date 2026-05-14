extends Area2D

var speed = 200
var direction = Vector2.RIGHT
var knockback = 10
var damage = 50
func _process(delta: float) -> void:
	position += direction * speed * delta



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body._damage($".")
		queue_free()
