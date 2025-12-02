extends AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var zach: Sprite2D = $Zachary
@onready var mc: CharacterBody2D = $"../../MC"
@onready var ani_play: AnimationPlayer = $"../../MC/Camera2D/Fade/AnimationPlayer"


func _on_animation_finished() -> void:
	timer.start()


func _on_timer_timeout() -> void:
	#zach.show()
	#print("this works")
	# change to credits scene
	ani_play.play("fading")
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fading":
		get_tree().change_scene_to_file("res://scenes/credits.tscn")
