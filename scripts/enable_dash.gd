extends Area2D
	
@onready var bar: ProgressBar = $"../MC/ProgressBar"

func _on_body_entered(body: Node2D) -> void:
	print(body)
	if (body is CharacterBody2D):
		bar.show()
		print(body)
