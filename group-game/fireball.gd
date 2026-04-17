extends CharacterBody2D

var speed = 400
var bounces = 0
var max_bounces = 5
var direction = Vector2.DOWN # Default direction

func _ready():
	# Allow custom direction to be set by the spawner
	velocity = direction.normalized() * speed

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		# Reflect the velocity
		velocity = velocity.bounce(collision.get_normal())
		bounces += 1
		
		# Check if it hit a wall (assuming walls are TileMap or StaticBody2D)
		if bounces > max_bounces:
			queue_free() # Delete after 5 bounces

# Detect hitting the player
func _on_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage()
		queue_free()
