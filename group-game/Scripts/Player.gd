extends CharacterBody2D


var SPEED = 350.0
const JUMP_VELOCITY = -400.0
const accel = 100
var dodge = false
var dodge_cooldown = false
var interactable_trigger = false
var interactable = NAN


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Dodge") and dodge_cooldown == false:
		Dodge()
	if dodge == false:
		var move_vector: Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
		velocity = velocity.move_toward(move_vector * SPEED, accel)
		if velocity.y < 0 and velocity.x == 0:
			$AnimatedSprite2D.play("Up")
		elif velocity.y < 0 and velocity.x < 0:
			$AnimatedSprite2D.play("UpLeft")
		elif velocity.y < 0 and velocity.x > 0:
			$AnimatedSprite2D.play("UpRight")
		elif velocity.y > 0 and velocity.x == 0:
			$AnimatedSprite2D.play("Down")
		elif velocity.y > 0 and velocity.x < 0:
			$AnimatedSprite2D.play("DownLeft")
		elif velocity.y > 0 and velocity.x > 0:
			$AnimatedSprite2D.play("DownRight")
		elif velocity.y == 0 and velocity.x < 0:
			$AnimatedSprite2D.play("Left")
		elif velocity.y == 0 and velocity.x > 0:
			$AnimatedSprite2D.play("Right")
		elif $AnimatedSprite2D.animation == "Up":
			$AnimatedSprite2D.play("Up_Idle")
		elif $AnimatedSprite2D.animation == "UpLeft":
			$AnimatedSprite2D.play("UpLeft_Idle")
		elif $AnimatedSprite2D.animation == "UpRight":
			$AnimatedSprite2D.play("UpRight_Idle")
		elif $AnimatedSprite2D.animation == "Down":
			$AnimatedSprite2D.play("Down_Idle")
		elif $AnimatedSprite2D.animation == "DownLeft":
			$AnimatedSprite2D.play("DownLeft_Idle")
		elif $AnimatedSprite2D.animation == "DownRight":
			$AnimatedSprite2D.play("DownRight_Idle")
		elif $AnimatedSprite2D.animation == "Left":
			$AnimatedSprite2D.play("Left_Idle")
		elif $AnimatedSprite2D.animation == "Right":
			$AnimatedSprite2D.play("Right_Idle")
			
	print($AnimatedSprite2D.animation)
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
	elif $AnimatedSprite2D.animation == "UpLeft" or $AnimatedSprite2D.animation == "UpLeft_Idle":
		velocity = Vector2(-707, -707)
		$AnimatedSprite2D.play("Roll_UpLeft")
	elif $AnimatedSprite2D.animation == "UpRight" or $AnimatedSprite2D.animation == "UpRight_Idle":
		velocity = Vector2(707, -707)
		$AnimatedSprite2D.play("Roll_UpRight")
	elif $AnimatedSprite2D.animation == "Down" or $AnimatedSprite2D.animation == "Down_Idle":
		velocity = Vector2(0, 1000)
		$AnimatedSprite2D.play("Roll_Down")
	elif $AnimatedSprite2D.animation == "DownLeft" or $AnimatedSprite2D.animation == "DownLeft_Idle":
		velocity = Vector2(-707, 707)
		$AnimatedSprite2D.play("Roll_DownLeft")
	elif $AnimatedSprite2D.animation == "DownRight" or $AnimatedSprite2D.animation == "DownRight_Idle":
		velocity = Vector2(707, 707)
		$AnimatedSprite2D.play("Roll_DownRight")
	elif $AnimatedSprite2D.animation == "Left" or $AnimatedSprite2D.animation == "Left_Idle":
		velocity = Vector2(-1000, 0)
		$AnimatedSprite2D.play("Roll_Left")
	elif $AnimatedSprite2D.animation == "Right" or $AnimatedSprite2D.animation == "Right_Idle":
		velocity = Vector2(1000, 0)
		$AnimatedSprite2D.play("Roll_Right")

func _on_dodge_timer_timeout() -> void:
	dodge = false


func _on_dodge_cooldown_timeout() -> void:
	dodge_cooldown = false


func _on_interaction_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Interactable"):
		interactable_trigger = true
	


func _on_interaction_range_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
