extends Area2D
@onready var sprite : Sprite2D = $Sprite2D
@export var Attributes: arrow_resource
var direction: int
var damage: int
var knockback: int
var target: String
var speed: float
var right_texture = preload("res://Sprites/Arrow Right.png")
var up_texture = preload("res://Sprites/Arrow Up.png")
var left_texture = preload("res://Sprites/Arrow Left.png")
var down_texture = preload("res://Sprites/Arrow Down.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	direction = Attributes.direction
	damage = Attributes.damage
	knockback = Attributes.knockback
	target = Attributes.target
	speed = Attributes.speed
	if direction == 1:
		sprite.texture = right_texture
	if direction == 2:
		sprite.texture = up_texture
	if direction == 3:
		sprite.texture = left_texture
	if direction == 4:
		sprite.texture = down_texture
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if direction == 1:
		position.x += speed
	if direction == 2:
		position.y -= speed
	if direction == 3:
		position.x -= speed
	if direction == 4:
		position.y += speed


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(target):
		body._damage($".")
		queue_free()
