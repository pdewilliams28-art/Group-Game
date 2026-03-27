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
func _ready() -> void:
	speed = attributes.speed
	damage = attributes.damage
	health = attributes.health
	max_health = health
	knockback = attributes.knockback
	sprite.sprite_frames = attributes.texture

func _physics_process(delta: float) -> void:
	if target:
		chase_target()
	else:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.stop()
	move_and_slide()
func chase_target():
	var distance_to_player: Vector2
	distance_to_player = target.global_position - global_position
	var direction_normal: Vector2 = distance_to_player.normalized()
	velocity = direction_normal * speed
	$AnimatedSprite2D.play()
	
	
func _on_detection_range_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body
	
func _on_detection_range_body_exited(body: Node2D) -> void:
	if body is Player:
		target = null


func _process(delta: float) -> void:
	update_health_bar(health, max_health)
	if health > max_health:
		health = max_health
	health_bar.max_value = max_health
	health_bar.value = health - max_health/10
func update_health_bar(current_hp, max_hp):
	var health_pct = float(current_hp) / max_hp
	health_bar.value = current_hp
	
	# lerp(Color_at_0, Color_at_1, weight)
	# As health_pct goes from 1.0 (full) to 0.0 (empty), color shifts from Green to Red
	health_bar.tint_progress = Color.RED.lerp(Color.GREEN, health_pct-.3)
	



func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.name == "Sword_Attack":
		health -= 10
		print("ow")
