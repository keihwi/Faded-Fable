extends Sprite2D

var has_fallen: bool = false
@onready var fall_timer: Timer = $FallTimer


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and !has_fallen:
		fall_timer.start()
		
		
func _disable_collider():
	$StaticBody2D/CollisionShape2D.disabled = true


func _on_fall_timer_timeout() -> void:
	var opacity_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
	var pos_tween: Tween = create_tween().set_trans(Tween.TRANS_SINE)
		
	opacity_tween.tween_property(self, "modulate:a", 0.0, 0.5)
	pos_tween.tween_property(self, "global_position", global_position+Vector2(0,12), 0.5)
		
	opacity_tween.finished.connect(_disable_collider)
		
	has_fallen = true
