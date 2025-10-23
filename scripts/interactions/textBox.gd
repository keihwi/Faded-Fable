extends MarginContainer

@onready var label: Label = $MarginContainer/Label
@onready var timer: Timer = $LetterDisplayTimer
@onready var fade_arrow: AnimationPlayer = $fade_arrow
@onready var arrow: TextureRect = $MarginContainer/arrow


const MAX_WIDTH = 256

var dialog_lines: Array[String] = []
var current_line_index: int = 0

var text: String = ""
var letter_index: int = 0

var letter_time: float = 0.01
var space_time: float = 0.03
var punctuation_time: float = 0.06

var is_dialog_active: bool = false
var can_advance_line: bool = false
var is_dialog_finished_permanently: bool = false

signal dialog_finished()

func _ready():
	visible = false   # start hidden
	arrow.hide()

func start_dialog(lines: Array[String]):
	if is_dialog_active or is_dialog_finished_permanently: 
		return
	print
	# reset flags before starting
	is_dialog_finished_permanently = false
	can_advance_line = false
	
	dialog_lines = lines
	current_line_index = 0
	is_dialog_active = true
	visible = true
	_show_line()



func _show_line():
	visible = true 
	text = dialog_lines[current_line_index]

	# temporarily hide the label visually but not logically (to prevent text flash)
	label.modulate.a = 0.0

	# reset layout
	label.autowrap_mode = TextServer.AUTOWRAP_OFF
	label.text = text
	await get_tree().process_frame  

	# all text boxes the same size, only expand on y
	custom_minimum_size.x = MAX_WIDTH

	if label.get_minimum_size().x > MAX_WIDTH:
		# wrap on long text
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await get_tree().process_frame
		custom_minimum_size.y = label.get_minimum_size().y
	else:
		custom_minimum_size.y = 0  

	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER  

	# now restore visibility
	label.modulate.a = 1.0

	# typewriter effect
	label.text = ""
	letter_index = 0
	can_advance_line = false
	_display_letter()





func _display_letter():
	label.text += text[letter_index]
	letter_index += 1
	
	if letter_index >= text.length():
		can_advance_line = true
		arrow.show()
		fade_arrow.play("arrow")
		return
	
	# set times for different char (maybe utilize later for slower sensual text haha)
	match text[letter_index]:
		"!", ".", ",", "?", "~":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)

# E to advance dialog
func _unhandled_input(event):
	if (event.is_action_pressed("interact") and is_dialog_active and can_advance_line):
		get_tree().root.set_input_as_handled()
		arrow.hide()
		current_line_index += 1
		
		if (current_line_index >= dialog_lines.size()):
			is_dialog_active = false
			is_dialog_finished_permanently = true 
			emit_signal("dialog_finished")
			visible = false
			return
		
		_show_line()


func _on_letter_display_timer_timeout() -> void:
	_display_letter()
