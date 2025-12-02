extends Node2D
@onready var ani_play: AnimationPlayer = $AnimationPlayer



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "roll":
		ani_play.play("fade")
	if anim_name == "fade":
		get_tree().change_scene_to_file("res://scenes/title.tscn")
