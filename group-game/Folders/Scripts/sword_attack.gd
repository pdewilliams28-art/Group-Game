extends Area2D
@export var damage: int = 200
@export var knockback: int = 4
# Called when the node enters the scene tree for the first time.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_attack() -> void:
	playsound_with_pitch_variation(get_parent().sword_swish_sfx,0.2)
func playsound_and_wait(sfx):
	get_parent().playsound_and_wait(sfx)
func playsound(sfx):
	get_parent().playsound(sfx)
func playsound_with_pitch_variation(sfx,pitch_variation):
	get_parent().playsound_with_pitch_variation(sfx,pitch_variation)
