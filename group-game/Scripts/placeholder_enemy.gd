extends CharacterBody2D
@export var attributes: Enemy_resource
@onready var sprite : Sprite2D = $Sprite2D
@onready var health_bar: ProgressBar = $ProgressBar
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
	sprite.texture = attributes.texture

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
func _process(delta: float) -> void:
	var health_pct: float = float(health)/max_health
	var new_color = Color.RED.lerp(Color.GREEN, health_pct)
	var sb = health_bar.get_theme_stylebox("fill").duplicate()
	sb.bg_color = new_color
	health_bar.add_theme_stylebox_override("fill", sb)
	if health > max_health:
		health = max_health
	health_bar.max_value = max_health
	health_bar.value = health
	if Input.is_action_just_pressed("Dodge"):
		health -= 10
