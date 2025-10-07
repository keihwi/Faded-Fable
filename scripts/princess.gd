extends StaticBody2D

@onready var text_box: MarginContainer = $"../TextBox"
@onready var interactable: Area2D = $Interactable


# How dialogue is transmitted
const lines: Array[String] = [
	"Good evening!",
	"It's lovely to meet you.",
	"I was just singing to the crows...",
	"I don’t get many visitors these days.",
	"Just a view of devastation out one window...",
	"...and isolation in my bedroom...",
]

func _ready() -> void:
	#print("Honeydew interactable is: ", interactable)  # which node is this?
	#print("Script on interactable: ", interactable.get_script())
	interactable.interact = _on_interact

func _on_interact():
	#print("Honeydew interact")
	text_box.start_dialog(lines)
	interactable.is_interactable = false
