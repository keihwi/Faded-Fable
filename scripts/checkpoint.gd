extends Area2D

@onready var mc: CharacterBody2D = $"../../MC"

func _on_body_entered(body: Node2D) -> void:
	#print(body)
	if body is CharacterBody2D:
		#print("respawn")
		mc.spawn = global_position
		queue_free()
	
