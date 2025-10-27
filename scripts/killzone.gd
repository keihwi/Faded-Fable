extends Area2D

@onready var timer: Timer = $Timer
@onready var mc: CharacterBody2D = $"../MC"


func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").disabled = true
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1 #default
	mc.velocity = Vector2.ZERO
	mc.get_node("CollisionShape2D").disabled = false
	mc.global_position = mc.spawn
	#get_tree().reload_current_scene()
