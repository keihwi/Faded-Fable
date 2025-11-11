extends StaticBody2D

@onready var honeydew: StaticBody2D = $"../NPCs/Honeydew_End/StaticBody2D"
@onready var step_on: CollisionShape2D = $StepOn

func _ready():
	visible = false
	step_on.disabled = true

func check_activation():
	if honeydew.level1_letters >= 2:
		print("Bridge activated!")
		visible = true
		await get_tree().process_frame
		$StepOn.disabled = false
