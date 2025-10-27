extends StaticBody2D

@onready var text_box: MarginContainer = $"../TextBox"
@onready var interactable: Area2D = $Interactable

var level1_letters = 0
var talkedTo

# How dialogue is transmitted
# Maybe have this dialogue be what she says after being talked to? or just have things repeat.
const lines: Array[String] = [
	"Hey!",
]

const lines1: Array[String] = [
	"I’ve never seen such a mature harvest—I mean… capable traveler...",
	"Hello wanderer~",
	"I don’t get many visitors these days.",
	"As you can see, the br_dg_ once used to bring my bountiful harvest to the rest of the kingdom has weathered away.",
	"Now, my harvest can’t be fertilized~~!!",
	"My fruits were the purest, most elegant things to behold...",
	"Would you please help me fix the br_dg_?~",
]

const lines2: Array[String] = [
	"You did it!",
]

func _ready() -> void:
	#print("Honeydew interactable is: ", interactable)  # which node is this?
	#print("Script on interactable: ", interactable.get_script())
	interactable.interact = _on_interact

func _on_interact():
	#print("Honeydew interact") 
	if(level1_letters < 1): 
		text_box.start_dialog(lines1) 
	else: 
		text_box.start_dialog(lines2) 
	interactable.is_interactable = false 
		
func _on_text_box_dialog_finished() -> void: 
	# Check if the text box is *still* inactive, just to be safe. 
	if (not text_box.is_dialog_active): 
		interactable.is_interactable = true 
		text_box.is_dialog_finished_permanently = false
	
