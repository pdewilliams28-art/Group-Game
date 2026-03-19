extends CharacterBody2D
class_name Player

var SPEED: float = 350.0
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
				if sqrt(pow(((position.x-body.position.x)*40),2) + pow(((position.y-body.position.y)*40),2)) >= 1000:
					velocity += Vector2((position.x-body.position.x)*40,(position.y-body.position.y)*40)
					print(Vector2((position.x-body.position.x)*40,(position.y-body.position.y)*40))
					Invincible = true
					$Invincibility_Timer.start()
					stagger = true
				else:
					#add velocity in random direction
					pass
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
