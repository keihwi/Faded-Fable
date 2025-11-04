extends ProgressBar

@onready var mc: CharacterBody2D = $".."

func _ready():
	set_process(true)
	value = 100

func _process(delta: float) -> void:
	if mc.is_dashing:
		value -= 1
	elif mc.can_dash:
		value += 1

func _on_dash_timer_timeout() -> void:
	value = 0
