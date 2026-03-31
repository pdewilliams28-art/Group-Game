extends CharacterBody2D
@export var attributes: Enemy_resource
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: TextureProgressBar = $"Health Bar"
var speed: float
var target: Node2D
var damage: int
var health: int
var max_health: int
var knockback: float
var knockback_taken: float
var player_position: Vector2
var accel: float = 10
func _ready() -> void:
	speed = attributes.speed
	damage = attributes.damage
	health = attributes.health
	max_health = health
	knockback = attributes.knockback
	sprite.sprite_frames = attributes.texture

func _physics_process(_delta: float) -> void:
	if target:
		chase_target()
	else:
		if not velocity == Vector2.ZERO:
			velocity = velocity * 0.1
			if velocity.x < 0.1 and velocity.y < 0.1:
				velocity = Vector2.ZERO
		$AnimatedSprite2D.stop()
	if not knockback_taken == 0:
		
		velocity = (global_position - player_position) * knockback_taken
		knockback_taken =0
	move_and_slide()
func chase_target():
	var distance_to_player: Vector2
	distance_to_player = target.global_position - global_position
	var direction_normal: Vector2 = distance_to_player.normalized()
	velocity = velocity.move_toward(direction_normal*speed,accel)
	$AnimatedSprite2D.play()
	
	
func _on_detection_range_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body
	
func _on_detection_range_body_exited(body: Node2D) -> void:
	if body is Player:
		target = null


func _process(_delta: float) -> void:
	update_health_bar(health, max_health)
	if health > max_health:
		health = max_health
	health_bar.max_value = max_health
	health_bar.value = health - float(max_health)/10
func update_health_bar(current_hp, max_hp):
	var health_pct = float(current_hp) / max_hp
	health_bar.value = current_hp
	
	# lerp(Color_at_0, Color_at_1, weight)
	# As health_pct goes from 1.0 (full) to 0.0 (empty), color shifts from Green to Red
	health_bar.tint_progress = Color.RED.lerp(Color.GREEN, health_pct-.3)
	



func _on_hurtbox_area_entered(area: Area2D) -> void:
	health -= 10
	print("ow")
	knockback_taken =4
	player_position = area.global_position
