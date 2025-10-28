extends Area2D

@onready var mc: CharacterBody2D = $"../../MC"
@onready var honeydew: StaticBody2D = $"../../NPCs/Honeydew/StaticBody2D"
@onready var bridge: StaticBody2D = $"../../BrokenBridge"

func _on_body_entered(body: Node2D) -> void:
	print("+1 letter")
	honeydew.level1_letters += 1
	print(honeydew.level1_letters)
	bridge.check_activation()
	queue_free()
