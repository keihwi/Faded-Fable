extends MarginContainer

@onready var label: Label = $MarginContainer/Label
@onready var timer: Timer = $LetterDisplayTimer

const MAX_WIDTH = 100

var dialog_lines: Array[String] = []
var current_line_index: int = 0

var text: String = ""
var letter_index: int = 0

var letter_time: float = 0.03
var space_time: float = 0.06
var punctuation_time: float = 0.2

var is_dialog_active: bool = false
var can_advance_line: bool = false
var is_dialog_finished_permanently: bool = false

signal dialog_finished()

func _ready():
	visible = false   # start hidden

func start_dialog(lines: Array[String]):
	if is_dialog_active or is_dialog_finished_permanently:
		return
	
	dialog_lines = lines
	current_line_index = 0
	
	is_dialog_active = true
	_show_line()


func _show_line():
	visible = true 
	text = dialog_lines[current_line_index]
	label.text = text
	
	await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		label.autowrap.mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
	
	label.text = ""
	letter_index = 0
	_display_letter()
	can_advance_line = false

func _display_letter():
	label.text += text[letter_index]
	letter_index += 1
	
	if letter_index >= text.length():
		can_advance_line = true
		return
	
	match text[letter_index]:
		"!", ".", ",", "?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)

# E to advance dialog
func _unhandled_input(event):
	if event.is_action_pressed("interact") and is_dialog_active and can_advance_line:
		current_line_index += 1
		
		if current_line_index >= dialog_lines.size():
			is_dialog_active = false
			is_dialog_finished_permanently = true 
			emit_signal("dialog_finished")
			visible = false
			return
		
		_show_line()


func _on_letter_display_timer_timeout() -> void:
	_display_letter()
