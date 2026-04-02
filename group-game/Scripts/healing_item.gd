extends Area2D
@export var Attributes: consumable_resource
var decay_time: int
var health_amount: int
@onready var texture: SpriteFrames = Attributes.texture
var consumed_sfx: AudioStream
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	decay_time = Attributes.decay_time
	health_amount = Attributes.healing_amount
	consumed_sfx = Attributes.consumed_sfx
	$AnimatedSprite2D.sprite_frames = texture
	$AnimatedSprite2D.play("default")
	#name of animation inside spriteframes must be named "default"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	await get_tree().create_timer(decay_time).timeout
	queue_free()



func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		queue_free()
		body.playsound_and_wait(consumed_sfx)
		body.health += health_amount
		
