extends AnimatedSprite2D

#The direction of the fireball decides the sprite and the collision shape
#When the fireball hits the wall, it rebounds, maximum of 5 times, before being queue_free-ed
#When the fireball hits the player, it knocks them back & they take damage, then its queue_free-ed
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
