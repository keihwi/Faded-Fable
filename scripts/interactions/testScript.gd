extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var text_box: MarginContainer = $TextBox

# How dialogue is transmitted
const lines: Array[String] = [
	"Hi I'm godot.",
	"I hope this works...", 
]

func _ready() -> void:
	interactable.interact = _on_interact
	

func _on_interact():
	text_box.start_dialog(lines)
	interactable.is_interactable = false
	
