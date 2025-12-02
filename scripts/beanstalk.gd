extends AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var zach: Sprite2D = $Zachary


func _on_animation_finished() -> void:
	timer.start()


func _on_timer_timeout() -> void:
	zach.show()
	print("this works")
	# change to credits scene
	#get_tree().change_scene_to_file("res://scenes/credits.tscn")
