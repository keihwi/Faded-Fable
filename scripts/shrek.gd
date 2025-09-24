extends StaticBody2D

@onready var text_box: MarginContainer = $"../TextBox"
@onready var interactable: Area2D = $Interactable


# How dialogue is transmitted
const lines: Array[String] = [
	"I’ve never seen such a mature harvest—I mean… capable traveler...",
	"Hello wanderer~",
	"I don’t get many visitors these days. As you can see, the br_dg_ once used to display my bountiful harvest to the rest of the kingdom has weathered away.",
	"Now, my harvest can’t be fertilized~~!! My fruits were the purest, most elegant things to behold...",
	"Would you please help me fix the br_dg_?~",
]

func _ready() -> void:
	print("Honeydew interactable is: ", interactable)  # which node is this?
	print("Script on interactable: ", interactable.get_script())
	interactable.interact = _on_interact

func _on_interact():
	print("Honeydew interact")
	text_box.start_dialog(lines)
	interactable.is_interactable = false
