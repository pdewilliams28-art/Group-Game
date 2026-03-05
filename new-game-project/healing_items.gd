extends Area2D

@export var attributes : Healing_Items

var energy : float
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var sound : AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# fill the values from our resources
	energy = attributes.energy
	sprite.texture = attributes.texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		SceneManager.player_hp += energy
		animation.play()
		
func del_eat_food():
	queue_free()
