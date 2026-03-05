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
		dodge = true
		dodge_cooldown = true
		$Dodge_Timer.start()
		$Dodge_Cooldown.start()
		$CollisionShape2D.disabled = true
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

func _on_dodge_timer_timeout() -> void:
	dodge = false


func _on_dodge_cooldown_timeout() -> void:
	dodge_cooldown = false


func _on_interaction_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Interactable"):
		interactable_trigger = true
	


func _on_interaction_range_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
