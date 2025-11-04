extends Sprite2D

var has_fallen: bool = false
@onready var fall_timer: Timer = $FallTimer
@onready var respawn_timer: Timer = $RespawnTimer
var opacity_tween
var pos_tween
var start_position: Vector2

func _ready():
	start_position = global_position


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and !has_fallen:
		fall_timer.start()
		
		
func _disable_collider():
	$StaticBody2D/CollisionShape2D.disabled = true


func _on_fall_timer_timeout() -> void:
	tween_fall()
	has_fallen = true
	respawn_timer.start()
	print("fallen")

func tween_fall() -> void:
	opacity_tween = create_tween().set_trans(Tween.TRANS_SINE)
	pos_tween = create_tween().set_trans(Tween.TRANS_SINE)
	opacity_tween.tween_property(self, "modulate:a", 0.0, 0.5)
	pos_tween.tween_property(self, "global_position", global_position+Vector2(0,12), 0.5)
		
	opacity_tween.finished.connect(_disable_collider)
	
func _on_respawn_timer_timeout() -> void:
	print("respawn")
	global_position = start_position
	opacity_tween = create_tween().set_trans(Tween.TRANS_SINE)
	opacity_tween.tween_property(self, "modulate:a", 1.0, 0.5)
	$StaticBody2D/CollisionShape2D.disabled = false
	has_fallen = false
