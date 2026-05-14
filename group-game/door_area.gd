extends StaticBody2D

@export var button_presses_needed: int = 3
var buttons_pressed: int = 0


func _on_puzzle_button_pressed():
	buttons_pressed += 1
	if buttons_pressed >= button_presses_needed:
		visible = false
		$CollisionShape2D.set_deferred("disabled", true)
		print("door open")
		
		
		
func _on_puzzle_button_unpressed():
	buttons_pressed -= 1
	if buttons_pressed < button_presses_needed:
		visible = true
		$CollisionShape2D.set_deferred("disabled", false)
		
