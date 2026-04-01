
extends CharacterBody2D
class_name Player
@export var health: int = 200
var max_health: int = health
@export var mana: int = 200
var max_mana: int = mana
@export var SPEED: float = 350.0
const JUMP_VELOCITY = -400.0
const accel = 100
var dodge: bool = false
var dodge_cooldown: bool = false
var interactable_trigger: bool = false
var Invincible: bool = false
var interactable = NAN
var direction: int = 0
var attacking = false
var stagger = false
@export var sword_swish_sfx: AudioStream = preload("res://Sounds/Knife Swish.mp3.mp3")
@export var example_sound: AudioStream = preload("res://Sounds/alex_jauk-slap-237622.mp3")
@onready var audio_player = %"Sound_effects"
@onready var health_bar: TextureProgressBar = %"Health Bar"
@onready var mana_bar: TextureProgressBar = %"Mana Bar"
func _ready() -> void:
	attacking = false
	$Sword_Attack/Hitbox.disabled = true
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("Dodge") and dodge_cooldown == false and attacking == false:
		Dodge()
	if dodge == false and attacking == false:
		var move_vector: Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
		velocity = velocity.move_toward(move_vector * SPEED, accel)
		if direction == 1:
			$AnimatedSprite2D.play("Up")
		elif direction == 1:
			$AnimatedSprite2D.play("Up")
		elif direction == 4:
			$AnimatedSprite2D.play("Right")
		elif direction == 2 :
			$AnimatedSprite2D.play("Down")
		elif direction == 3:
			$AnimatedSprite2D.play("Left")
		elif direction == 2:
			$AnimatedSprite2D.play("Down")
		elif direction == 3:
			$AnimatedSprite2D.play("Left")
		elif direction == 4:
			$AnimatedSprite2D.play("Right")
		elif $AnimatedSprite2D.animation == "Up":
			$AnimatedSprite2D.play("Up_Idle")
		elif $AnimatedSprite2D.animation == "Down":
			$AnimatedSprite2D.play("Down_Idle")
		elif $AnimatedSprite2D.animation == "Left":
			$AnimatedSprite2D.play("Left_Idle")
		elif $AnimatedSprite2D.animation == "Right":
			$AnimatedSprite2D.play("Right_Idle")
			
	if  Input.is_action_just_pressed("Up"):
		direction = 1
	if Input.is_action_just_released("Up") and direction == 1:
		if Input.is_action_pressed("Down"):
			direction = 0
		if Input.is_action_pressed("Left"):
			direction = 3
		if Input.is_action_pressed("Right"):
			direction = 4
	if Input.is_action_just_pressed("Down"):
		direction = 2
	if Input.is_action_just_released("Down") and direction == 2:
		if Input.is_action_pressed("Up"):
			direction = 0
		if Input.is_action_pressed("Left"):
			direction = 3
		if Input.is_action_pressed("Right"):
			direction = 4
	if Input.is_action_just_pressed("Left"):
		direction = 3
	if Input.is_action_just_released("Left") and direction == 3:
		if Input.is_action_pressed("Down"):
			direction = 2
		elif Input.is_action_pressed("Up"):
			direction = 1
		elif Input.is_action_pressed("Right"):
			direction = 0
	if Input.is_action_just_pressed("Right"):
		direction = 4
	if Input.is_action_just_released("Right") and direction == 4:
		if Input.is_action_pressed("Down"):
			direction = 2
		elif Input.is_action_pressed("Left"):
			direction = 0
		elif Input.is_action_pressed("Up"):
			direction = 1
	if Input.is_action_just_released("Up") and direction == 1:
		direction = 0
	if Input.is_action_just_released("Down") and direction == 2:
		direction = 0
	if Input.is_action_just_released("Left") and direction == 3:
		direction = 0
	if Input.is_action_just_released("Right") and direction == 4:
		direction = 0
	if Input.is_action_just_pressed("Attack") and attacking == false and stagger == false and dodge == false:
		Attack()
	move_and_slide()
	

func Attack():
	attacking = true
	$Attack_Timer.start()
	print(attacking)
	$Sword_Attack/Hitbox.disabled = false
	velocity = Vector2(0, 0)
	playsound_with_pitch_variation(sword_swish_sfx,0.2)
	if $AnimatedSprite2D.animation == "Up" or $AnimatedSprite2D.animation == "Up_Idle":
		$AnimationPlayer.play("Sword_Up")
		$AnimatedSprite2D.play("Attack_Up")
	elif $AnimatedSprite2D.animation == "Down" or $AnimatedSprite2D.animation == "Down_Idle":
		$AnimationPlayer.play("Sword_Down")
		$AnimatedSprite2D.play("Attack_Down")
	elif $AnimatedSprite2D.animation == "Left" or $AnimatedSprite2D.animation == "Left_Idle":
		$AnimationPlayer.play("Sword_Left")
		$AnimatedSprite2D.play("Attack_Left")
	elif $AnimatedSprite2D.animation == "Right" or $AnimatedSprite2D.animation == "Right_Idle":
		$AnimationPlayer.play("Sword_Right")
		$AnimatedSprite2D.play("Attack_Right")

func _process(_delta: float) -> void:
	var bodies = $Hurtbox.get_overlapping_bodies()
	for body in bodies:
		#print("hit!")
		if body.is_in_group("Enemy"):
			if Invincible == false:
				if sqrt(pow(((position.x-body.position.x)*body.knockback),2) + pow(((position.y-body.position.y)*body.knockback),2)) >= 25 *body.knockback:
					health -= body.damage
					print(health)
					velocity += Vector2((position.x-body.position.x)*body.knockback,(position.y-body.position.y)*body.knockback)
					print(velocity)
					Invincible = true
					$Invincibility_Timer.start()
					stagger = true
					playsound_and_wait(example_sound)
				else:
					health -= body.damage
					print(health)
					#add velocity in random direction
					var randv = randf_range(-PI,PI)
					velocity = Vector2(cos(randv),sin(randv))*50*body.knockback
					print(velocity)
					Invincible = true
					$Invincibility_Timer.start()
					playsound_and_wait(example_sound)
	if health <= 0:
		get_tree().call_deferred("reload_current_scene")
	update_health_bar(health, max_health)
	if health > max_health:
		health = max_health
	health_bar.max_value = 100
	health_bar.value = float(health) / max_health * 100
	mana_bar.max_value = 100
	mana_bar.value = float(mana) / max_mana * 100
	update_mana_bar(mana,max_mana)



func update_health_bar(current_hp, max_hp):
	var health_pct = float(current_hp) / max_hp
	# lerp(Color_at_0, Color_at_1, weight)
	# As health_pct goes from 1.0 (full) to 0.0 (empty), color shifts from Green to Red
	health_bar.tint_progress = Color.RED.lerp(Color.GREEN, health_pct-.3)



func update_mana_bar(current_m, max_m):
	var mana_pct = float(current_m) / max_m
	# lerp(Color_at_0, Color_at_1, weight)
	# As health_pct goes from 1.0 (full) to 0.0 (empty), color shifts from Green to Red
	mana_bar.tint_progress = Color.WHITE.lerp(Color.BLUE, mana_pct)



func Dodge():
	dodge = true
	dodge_cooldown = true
	$Dodge_Timer.start()
	$Dodge_Cooldown.start()
	$Hurtbox/Hurtbox.disabled = true
	if $AnimatedSprite2D.animation == "Up" or $AnimatedSprite2D.animation == "Up_Idle":
		velocity = Vector2(0, -1000)
		$AnimatedSprite2D.play("Roll_Up")
	elif $AnimatedSprite2D.animation == "Down" or $AnimatedSprite2D.animation == "Down_Idle":
		velocity = Vector2(0, 1000)
		$AnimatedSprite2D.play("Roll_Down")
	elif $AnimatedSprite2D.animation == "Left" or $AnimatedSprite2D.animation == "Left_Idle":
		velocity = Vector2(-1000, 0)
		$AnimatedSprite2D.play("Roll_Left")
	elif $AnimatedSprite2D.animation == "Right" or $AnimatedSprite2D.animation == "Right_Idle":
		velocity = Vector2(1000, 0)
		$AnimatedSprite2D.play("Roll_Right")



func _on_dodge_timer_timeout() -> void:
	dodge = false
	if $AnimatedSprite2D.animation == "Roll_Up":
		$AnimatedSprite2D.play("Up_Idle")
	if $AnimatedSprite2D.animation == "Roll_Down":
		$AnimatedSprite2D.play("Down_Idle")
	if $AnimatedSprite2D.animation == "Roll_Right":
		$AnimatedSprite2D.play("Right_Idle")
	if $AnimatedSprite2D.animation == "Roll_Left":
		$AnimatedSprite2D.play("Left_Idle")


func _on_dodge_cooldown_timeout() -> void:
	dodge_cooldown = false
	%Hurtbox.disabled = false


func _on_interaction_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Interactable"):
		interactable_trigger = true
	


@warning_ignore("unused_parameter")
func _on_interaction_range_body_exited(body: Node2D) -> void:
	pass # Replace with function body.



func _on_invincibility_timer_timeout() -> void:
	Invincible = false
	stagger = false



func _on_attack_timer_timeout() -> void:
	attacking = false
	$Sword_Attack/Hitbox.disabled = true
	if $AnimatedSprite2D.animation == "Attack_Up":
		$AnimatedSprite2D.play("Up_Idle")
	if $AnimatedSprite2D.animation == "Attack_Down":
		$AnimatedSprite2D.play("Down_Idle")
	if $AnimatedSprite2D.animation == "Attack_Left":
		$AnimatedSprite2D.play("Left_Idle")
	if $AnimatedSprite2D.animation == "Attack_Right":
		$AnimatedSprite2D.play("Right_Idle")



func playsound_and_wait(sound):
	audio_player.stream = sound
	var audio_length = audio_player.stream.get_length()
	audio_player.play()
	await get_tree().create_timer(audio_length +0.1).timeout

func playsound(sound):
	audio_player.stream = sound
	audio_player.play()

func playsound_with_pitch_variation(sound,pitch_variation):
	audio_player.stream = sound
	audio_player.pitch_scale = randf_range(1-pitch_variation, 1+pitch_variation)
	audio_player.play()
