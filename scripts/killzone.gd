extends Area2D

@onready var timer: Timer = $Timer
@onready var mc: CharacterBody2D = $"../MC"
@onready var sprite: AnimatedSprite2D = $"../MC/AnimatedSprite2D"

func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	#hit_sound.play()
	sprite.modulate = Color(1, 0.4, 0.4)
	
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").disabled = true
	timer.start()

func _on_timer_timeout() -> void:
	sprite.modulate = Color(1, 1, 1)
	Engine.time_scale = 1 #default
	mc.velocity = Vector2.ZERO
	mc.get_node("CollisionShape2D").disabled = false
	mc.global_position = mc.spawn
	#get_tree().reload_current_scene()
