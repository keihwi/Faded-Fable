extends StaticBody2D

@onready var text_box: MarginContainer = $"../TextBox"
@onready var interactable: Area2D = $Interactable


# How dialogue is transmitted
const lines: Array[String] = [
	"Hey I'm the princess!",
]

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	text_box.start_dialog(lines)
	interactable.is_interactable = false
