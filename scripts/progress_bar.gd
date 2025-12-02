extends ProgressBar

@onready var mc: CharacterBody2D = $".."
@onready var cd: Timer = $"../canDashTimer"
var fill_rate = 100.0 / 0.3  # = 333.333

func _ready():
	set_process(true)
	value = 100

func _process(delta: float) -> void:
	if mc.is_dashing:
		value -= fill_rate * delta
		value = max(value, 0)
	elif (not mc.can_dash) and cd.time_left <= 0.3:
		value += fill_rate * delta
		value = min(value, 100)
	#elif mc.can_dash:
		#value += 1

#func _on_dash_timer_timeout() -> void:
	#value = 0
