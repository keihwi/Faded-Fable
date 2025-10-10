extends StaticBody2D

@export var distance: int
@export var time: float
@export var start_left: bool

var paused = false

func _ready() -> void:
	if start_left:
		move_right()
	else:
		move_left()

func move_right():
	var tween = create_tween()
	tween.tween_property(self, "position", position + Vector2(distance,0), time)
	tween.tween_callback(move_left)
	
func move_left():
	var tween = create_tween()
	tween.tween_property(self, "position", position + Vector2(-distance,0), time)
	tween.tween_callback(move_right)
