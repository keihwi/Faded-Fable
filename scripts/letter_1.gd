extends Area2D

@onready var mc: CharacterBody2D = $"../../MC"
@onready var honeydew: StaticBody2D = $"../../NPCs/Honeydew/StaticBody2D"



func _on_body_entered(body: Node2D) -> void:
	print("+1 letter")
	honeydew.level1_letters += 1
	print(honeydew.level1_letters)
	queue_free()
	
