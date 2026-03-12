extends CharacterBody2D
class_name Player

var SPEED = 350.0
const JUMP_VELOCITY = -400.0
const accel = 100
var dodge = false
var dodge_cooldown = false
var interactable_trigger = false
var interactable = NAN
var direction: int = 0


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Dodge") and dodge_cooldown == false:
		dodge = true
		dodge_cooldown = true
		$Dodge_Timer.start()
		$Dodge_Cooldown.start()
		%Hurtbox.disabled = true
		if $AnimatedSprite2D.animation == "Up":
			velocity = Vector2(0, -1000)
		elif $AnimatedSprite2D.animation == "UpLeft":
			velocity = Vector2(-707, -707)
		elif $AnimatedSprite2D.animation == "UpRight":
			velocity = Vector2(707, -707)
		elif $AnimatedSprite2D.animation == "Down":
			velocity = Vector2(0, 1000)
		elif $AnimatedSprite2D.animation == "DownLeft":
			velocity = Vector2(-707, 707)
		elif $AnimatedSprite2D.animation == "DownRight":
			velocity = Vector2(707, 707)
		elif $AnimatedSprite2D.animation == "Left":
			velocity = Vector2(-1000, 0)
		elif $AnimatedSprite2D.animation == "Right":
			velocity = Vector2(1000, 0)
	if dodge == false:
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
	#print($AnimatedSprite2D.animation)
	move_and_slide()
	

func Dodge():
	dodge = true
	dodge_cooldown = true
	$Dodge_Timer.start()
	$Dodge_Cooldown.start()
	$CollisionShape2D.disabled = true
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
	


func _on_interaction_range_body_exited(body: Node2D) -> void:
	pass # Replace with function body.





func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		velocity += Vector2((position.x-body.position.x)*40,(position.y-body.position.y)*40)
