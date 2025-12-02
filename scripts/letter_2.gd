extends Area2D

@onready var mc: CharacterBody2D = $"../../MC"
@onready var princess: StaticBody2D = $"../../NPCs/Princess_End/StaticBody2D"
#@onready var bridge: StaticBody2D = $"../../BrokenBridge"

func _on_body_entered(body: Node2D) -> void:
	print("+1 letter")
	princess.level2_letters += 1
	print(princess.level2_letters)
	#bridge.check_activation()
	queue_free()
