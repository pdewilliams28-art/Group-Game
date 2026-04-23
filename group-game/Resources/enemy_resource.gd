extends Resource
class_name Enemy_resource
@export var health: int
@export var speed: float
@export var damage: int
@export var knockback: float
@export var texture: SpriteFrames
@export var heart_chance: int
@export var arrow_chance: int
##knockback_resistance would be between 0-100. would take x% of knockback and subtract it from it
@export var knockback_resistance: int
