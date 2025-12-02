extends StaticBody2D

@onready var text_box: MarginContainer = $"../TextBox"
@onready var interactable: Area2D = $Interactable
var level2_letters = 0
#var rooty = get_tree().get_root()  
@onready var beanstalk: AnimatedSprite2D = get_node('../../../Setting/Beanstalk') 

# How dialogue is transmitted
const lines: Array[String] = [
	"You haven't collected all the letters, brave soul.",
]

const lines1: Array[String] = [
	"Good evening!",
	"It's lovely to meet you.",
	"I was just singing to the crows...",
	"I don’t get many visitors these days.",
	"Just a view of devastation out one window...",
	"...and isolation in my bedroom...",
	"I need you to fix our b_anst_lk.",
	"It holds our pages together...",
	"It's safe to jump down the cliff behind me.",
	"I wish you luck on your journey.",
]

const lines2: Array[String] = [
	"Thank you!",
	"You've saved our story"
]

func _ready() -> void:
	#print("Honeydew interactable is: ", interactable)  # which node is this?
	#print("Script on interactable: ", interactable.get_script())
	interactable.interact = _on_interact

func _on_interact():
	#print("Honeydew interact")
	if(level2_letters < 2 and global_position == Vector2(8097.0, -720.0)): 
		text_box.start_dialog(lines1)  # beginning princess lines
	elif level2_letters < 2: 
		text_box.start_dialog(lines) # end princess if not all letters collected
	else: 
		text_box.start_dialog(lines2) # collected all letters at end
	interactable.is_interactable = false 

func _on_text_box_dialog_finished() -> void: 
	# Check if the text box is *still* inactive, just to be safe. 
	if (not text_box.is_dialog_active): 
		interactable.is_interactable = true 
		text_box.is_dialog_finished_permanently = false
	if level2_letters == 2: 
		#print(beanstalk)
		beanstalk.play("grow")
