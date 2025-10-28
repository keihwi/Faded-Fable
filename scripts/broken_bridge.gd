extends AnimatableBody2D

@onready var honeydew: StaticBody2D = $"../NPCs/Honeydew/StaticBody2D"
@onready var detect: CollisionShape2D = $Sense/CollisionShape2D

func _ready():
	visible = false
	$StepOn.disabled = true



func _on_sense_area_entered(area: Area2D) -> void:
	print("player entered")
	if(honeydew.level1_letters < 2): 
		$StepOn.disabled = false
		visible = true
		
