extends Resource
class_name arrow_resource
## directions should be 1-4. 1 is right, 2 is up, 3 is left, 4 is down.
@export var direction: int
@export var damage: int
@export var knockback: int
##what the arrow will damage. put the name of a global group inside the string (Ex: if you want the arrow to deal damage to enemies, put in the box, "Enemy" so you damage enemies)
@export var target: String
@export var speed: float
