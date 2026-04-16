extends CharacterBody2D
@export var attributes: Enemy_resource
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: TextureProgressBar = $"Health Bar"
var Heart_SCENE: PackedScene = preload("res://Scenes/healing_item.tscn")
var speed: float
var target: Node2D
var damage: int
var health: int
var max_health: int
var knockback: float
var knockback_taken: float
var knockback_resistance: float
var player_position: Vector2
var accel: float = 10

func _ready() -> void:
	speed = attributes.speed
	damage = attributes.damage
	health = attributes.health
	max_health = health
	knockback = attributes.knockback
	knockback_resistance = attributes.knockback_resistance
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
	velocity = velocity * 0.95
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
	if area.is_in_group("Player") == true:
		health -= area.damage
		#print("ow")
		knockback_taken = area.knockback
		knockback_taken -= (knockback_taken*knockback_resistance)/100
		player_position = area.global_position
		area.playsound(preload("res://Sounds/Sword Hit Flesh.mp3.mp3"))
		if health <= 0:
			var spawn_resource: consumable_resource = preload("res://Resources/Heart.tres")
			var new_instance = Heart_SCENE.instantiate()
			new_instance.Attributes = spawn_resource 
			new_instance.global_position = global_position
			get_parent().add_child(new_instance)
			area.playsound(preload("res://Sounds/universfield-slime-impact-352473.mp3"))
			queue_free()
			
func _damage(body: Node2D):
	health -= body.damage
	#print("ow")
	knockback_taken = body.knockback
	knockback_taken -= (knockback_taken*knockback_resistance)/100
	player_position = body.global_position
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		player.playsound(preload("res://Sounds/Sword Hit Flesh.mp3.mp3"))
	if health <= 0:
		if randi_range(1,10) < 5:
			var spawn_resource: consumable_resource = preload("res://Resources/Heart.tres")
			var new_instance = Heart_SCENE.instantiate()
			new_instance.Attributes = spawn_resource #this part is where im having trouble
			new_instance.global_position = global_position
			get_parent().add_child(new_instance)
		player.playsound(preload("res://Sounds/universfield-slime-impact-352473.mp3"))
		queue_free()
